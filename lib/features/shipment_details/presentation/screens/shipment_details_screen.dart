import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/core/public_widgets/loading_widget.dart';
import 'package:loadup/features/my_shipping/logic/cubit/sent_shipments_cubit.dart';
import 'package:loadup/features/shipment_details/presentation/widgets/detail_Item_widget.dart';

class ShipmentDetailsScreen extends StatefulWidget {
  const ShipmentDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ShipmentDetailsScreen> createState() => _ShipmentDetailsScreenState();
}

class _ShipmentDetailsScreenState extends State<ShipmentDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SentShipmentsCubit>().getshipments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shipment Details', style: AppTextStyles.font18BlackBold),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: BlocBuilder<SentShipmentsCubit, SentShipmentsState>(
          builder: (context, state) {
            if (state is SentShipmentsLoading) {
              return LoadingWidget();
            } else if (state is SentShipmentsError) {
              return Center(
                  child: Text(state.error,
                      style: AppTextStyles.font14GreyRegular));
            } else if (state is SentShipmentsSuccess) {
              final shipment = state.shipmentsModel.data.first;

              // Parse QR code to get shipment code
              final qrData = jsonDecode(shipment.qrCode ?? '{}');
              final shipmentCode = qrData['shipment_code'] ?? '';

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailItemWidget(
                        title: 'Shipment Code', value: shipmentCode),
                    DetailItemWidget(
                        title: 'Status', value: shipment.status ?? ''),
                    DetailItemWidget(
                        title: 'Cargo Type', value: shipment.typeOfCargo ?? ''),
                    DetailItemWidget(
                        title: 'Origin Address',
                        value: shipment.originAddress ?? ''),
                    DetailItemWidget(
                        title: 'Destination Address',
                        value: shipment.destinationAddress ?? ''),
                    DetailItemWidget(
                        title: 'Origin Center',
                        value: shipment.originCenter?.name ?? ''),
                    DetailItemWidget(
                        title: 'Destination Center',
                        value: shipment.destinationCenter?.name ?? ''),
                    DetailItemWidget(
                        title: 'Receiver Name',
                        value: shipment.receiver?.name ?? ''),
                    DetailItemWidget(
                        title: 'Receiver Phone',
                        value: shipment.receiver?.phone ?? ''),
                    DetailItemWidget(
                      title: 'Special Instructions',
                      value: shipment.specialHandlingInstructions ?? 'None',
                    ),
                    DetailItemWidget(
                      title: 'Created At',
                      value: shipment.createdAt.toString() ?? '',
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.location_pin,
                            size: 40,
                            color: AppColors.primaryOrange,
                          ),
                        ),
                      ),
                    ),
                    verticalSpace(10),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
