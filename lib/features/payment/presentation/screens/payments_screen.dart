import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/core/helpers/translation_extension.dart';
import 'package:loadup/core/routing/routes.dart';
import 'package:loadup/features/payment/logic/cubit/payments_cubit.dart';
import 'package:loadup/features/payment/logic/cubit/payments_state.dart';
import 'package:loadup/features/payment/presentation/widgets/payment_item_widget.dart';

class MyPaymentsScreen extends StatefulWidget {
  const MyPaymentsScreen({super.key});

  @override
  State<MyPaymentsScreen> createState() => _MyPaymentsScreenState();
}

class _MyPaymentsScreenState extends State<MyPaymentsScreen> {
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
              Text(
                context.tr('my_payments'),
                style: AppTextStyles.font24Bold(context),
              ),
              verticalSpace(20),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.pendingShipmentsScreen);
                },
                child: Card(
                  color: AppColors.primaryOrange.withOpacity(0.1),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primaryOrange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.local_shipping,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        horizontalSpace(12),
                        Expanded(
                          child: Text(
                            context.tr('pending_shipments'),
                            style: AppTextStyles.font16Bold(context),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios,
                            size: 18, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
              verticalSpace(20),
              BlocBuilder<PaymentsCubit, PaymentsState>(
                builder: (context, state) {
                  if (state is PaymentsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PaymentsError) {
                    return Center(child: Text(state.error));
                  } else if (state is PaymentsSuccess) {
                    final payments = state.payments.data ?? [];

                    if (payments.isEmpty) {
                      return const Expanded(
                        child: Center(child: Text("No Payments Found")),
                      );
                    }

                    return Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.tr('transaction_history'),
                            style: AppTextStyles.font18Bold(context),
                          ),
                          verticalSpace(16),
                          Expanded(
                            child: ListView.builder(
                              itemCount: payments.length,
                              itemBuilder: (context, index) {
                                final tx = payments[index];
                                return PaymentItemWidget(payment: tx);
                              },
                            ),
                          ),
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
}
