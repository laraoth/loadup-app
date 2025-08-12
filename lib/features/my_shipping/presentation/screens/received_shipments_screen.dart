import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/core/public_widgets/custom_bottom_navigation_bar.dart';
import 'package:loadup/core/public_widgets/loading_widget.dart';
import 'package:loadup/core/public_widgets/search_bar_widget.dart';
import 'package:loadup/features/my_shipping/logic/cubit/received_shipments_cubit.dart';
import 'package:loadup/features/my_shipping/presentation/widgets/shipping_filter_tabs_widget.dart';
import 'package:loadup/features/my_shipping/presentation/widgets/shipment_item_widget.dart';

Status getStatusFromString(String value) {
  switch (value.toLowerCase()) {
    case 'in transit':
      return Status.IN_TRANSIT;
    case 'delivered':
      return Status.DELIVERED;
    case 'pending':
    case 'pending for assignment':
      return Status.PENDING_FOR_ASSIGNMENT;
    case 'cancelled':
      return Status.CANCELLED;
    case 'draft':
      return Status.DRAFT;
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
      backgroundColor: AppColors.lightBackground,
      // bottomNavigationBar: const CustomBottomNavigationBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text('My Received Shipments',
                    style: AppTextStyles.font24BlackBold),
              ),
              verticalSpace(20),
              const SearchBarWidget(),
              verticalSpace(20),
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
                        child: Text(state.error,
                            style: AppTextStyles.font14GreyRegular),
                      );
                    } else if (state is ReceivedShipmentsSuccess) {
                      final shipments = state.shipmentsModel.data;

                      final filteredShipments = selectedTabIndex == 0
                          ? shipments
                          : shipments.where((s) {
                              final sStatus =
                                  getStatusFromString(s.status ?? '');
                              final selected = [
                                Status.IN_TRANSIT,
                                Status.DELIVERED,
                                Status.CANCELLED,
                                Status.DRAFT
                              ][selectedTabIndex - 1];
                              return sStatus == selected;
                            }).toList();

                      if (filteredShipments.isEmpty) {
                        return Center(
                          child: Text("No Shipments Found",
                              style: AppTextStyles.font14GreyRegular),
                        );
                      }

                      return ListView.separated(
                        itemCount: filteredShipments.length,
                        separatorBuilder: (context, index) => verticalSpace(10),
                        itemBuilder: (context, index) {
                          final shipment = filteredShipments[index];
                          return ShippingItemWidget(
                            code: shipment.shipmentCode ?? '',
                            status: getStatusFromString(shipment.status ?? ''),
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
