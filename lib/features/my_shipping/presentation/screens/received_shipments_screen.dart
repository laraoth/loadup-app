import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/core/public_widgets/loading_widget.dart';
import 'package:loadup/core/public_widgets/search_bar_widget.dart';
import 'package:loadup/features/my_shipping/logic/cubit/received_shipments_cubit.dart';
import 'package:loadup/features/my_shipping/presentation/widgets/received_shipment_item_widget.dart';
import 'package:loadup/features/my_shipping/presentation/widgets/shipping_filter_tabs_widget.dart';
import 'package:loadup/core/helpers/translation_extension.dart';

Status getStatusFromString(String value) {
  switch (value.toLowerCase()) {
    case 'draft':
      return Status.DRAFT;
    case 'pending admin approval':
      return Status.PENDING_ADMIN_APPROVAL;
    case 'rejected by admin':
      return Status.REJECTED_BY_ADMIN;
    case 'priced by admin':
      return Status.PRICED_BY_ADMIN;
    case 'pending customer approval':
      return Status.PENDING_CUSTOMER_APPROVAL;
    case 'rejected by customer':
      return Status.REJECTED_BY_CUSTOMER;
    case 'pending payment':
      return Status.PENDING_PAYMENT;
    case 'paid':
      return Status.PAID;
    case 'in transit':
      return Status.IN_TRANSIT;
    case 'delivered':
      return Status.DELIVERED;
    default:
      return Status.UNKNOWN;
  }
}

class ReceivedShipmentsScreen extends StatefulWidget {
  const ReceivedShipmentsScreen({super.key});

  @override
  State<ReceivedShipmentsScreen> createState() =>
      _ReceivedShipmentsScreenState();
}

class _ReceivedShipmentsScreenState extends State<ReceivedShipmentsScreen> {
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<ReceivedShipmentsCubit>().getreceivedshipments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  context.tr("my received shipments"),
                  style: AppTextStyles.font24Bold(context),
                ),
              ),
              // verticalSpace(20),
              // SearchBarWidget(),
              verticalSpace(30),
              ShippingFilterTabsWidget(
                selectedIndex: selectedTabIndex,
                onTabSelected: (index) {
                  setState(() => selectedTabIndex = index);
                },
              ),
              verticalSpace(20),
              Expanded(
                child:
                    BlocBuilder<ReceivedShipmentsCubit, ReceivedShipmentsState>(
                  builder: (context, state) {
                    if (state is ReceivedShipmentsLoading) {
                      return const LoadingWidget();
                    } else if (state is ReceivedShipmentsError) {
                      return Center(
                        child: Text(
                          state.error,
                          style: AppTextStyles.font14Grey(context),
                        ),
                      );
                    } else if (state is ReceivedShipmentsSuccess) {
                      final shipments = state.shipmentsModel.data;

                      final filteredShipments = selectedTabIndex == 0
                          ? shipments
                          : shipments.where((s) {
                              final sStatus =
                                  getStatusFromString(s.status ?? '');
                              return sStatus == Status.values[selectedTabIndex];
                            }).toList();

                      if (filteredShipments.isEmpty) {
                        return Center(
                          child: Text(
                            context.tr("no shipments found"),
                            style: AppTextStyles.font14Grey(context),
                          ),
                        );
                      }

                      return ListView.separated(
                        itemCount: filteredShipments.length,
                        separatorBuilder: (context, index) => verticalSpace(10),
                        itemBuilder: (context, index) {
                          final shipment = filteredShipments[index];
                          return ReceivedShippingItemWidget(
                            code: shipment.shipmentCode ?? '',
                            status: getStatusFromString(shipment.status ?? ''),
                            shipment: shipment,
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
