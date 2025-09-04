import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/core/helpers/translation_extension.dart';
import 'package:loadup/features/home/presentation/widgets/wallet_card_widget.dart';
import 'package:loadup/features/wallet/logic/cubit/payment_cubit.dart';
import 'package:loadup/features/wallet/logic/cubit/payment_state.dart';
import 'package:loadup/features/wallet/presentation/widgets/transaction_item_widget.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PaymentsCubit>().fetchPayments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(20),
              Text(context.tr('my_payments'),
                  style: AppTextStyles.font24Bold(context)),
              verticalSpace(35),
              BlocBuilder<PaymentsCubit, PaymentsState>(
                builder: (context, state) {
                  if (state is PaymentsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PaymentsError) {
                    return Center(child: Text(state.error));
                  } else if (state is PaymentsSuccess) {
                    final payments = state.payments.data;
                    final balance = payments.fold<double>(
                      0,
                      (sum, tx) => sum + tx.amount,
                    );

                    return Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // WalletCardWidget(
                          //   balance: balance.toStringAsFixed(2),
                          //   showAddIcon: true,
                          //   onAddTap: () {},
                          // ),
                          // verticalSpace(24),
                          Text(context.tr('transaction_history'),
                              style: AppTextStyles.font18Bold(context)),
                          verticalSpace(16),
                          Expanded(
                            child: ListView.builder(
                              itemCount: payments.length,
                              itemBuilder: (context, index) {
                                final tx = payments[index];
                                return TransactionItem(
                                  title:
                                      "${tx.paymentMethod} (Shipment #${tx.shipmentId})",
                                  amount: tx.amount.toStringAsFixed(2),
                                  isPositive: true,
                                );
                              },
                            ),
                          ),
                          verticalSpace(12),
                          _buildPaginationControls(context),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaginationControls(BuildContext context) {
    final cubit = context.read<PaymentsCubit>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (cubit.currentPage > 1)
          ElevatedButton(
            onPressed: cubit.prevPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.background(context),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            ),
            child: Text(context.tr('previous')),
          ),
        horizontalSpace(12),
        Text(
          context.tr("page ${cubit.currentPage} of ${cubit.lastPage}"),
          style: AppTextStyles.font16Regular(context),
        ),
        horizontalSpace(12),
        if (cubit.currentPage < cubit.lastPage)
          ElevatedButton(
            onPressed: cubit.nextPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.background(context),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            ),
            child: Text(context.tr('next')),
          ),
      ],
    );
  }
}
