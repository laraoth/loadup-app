import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/extentions.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/core/routing/routes.dart';
import 'package:loadup/features/my_shipping/data/model/shipment_model.dart';
import 'package:loadup/features/shipment_details/presentation/widgets/detail_Item_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:loadup/core/helpers/translation_extension.dart';

class ReceivedShipmentDetailsScreen extends StatelessWidget {
  final ShipmentDatum shipment;

  const ReceivedShipmentDetailsScreen({super.key, required this.shipment});

  @override
  Widget build(BuildContext context) {
    final qrRawString = shipment.qrCode ?? '{}';

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr("shipment_details"),
            style: AppTextStyles.font18Bold(context)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppColors.surface(context),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailItemWidget(
              title: context.tr("shipment_id"),
              value: shipment.id.toString(),
            ),
            DetailItemWidget(
              title: context.tr("shipment_code"),
              value: shipment.shipmentCode ?? '',
            ),
            DetailItemWidget(
              title: context.tr("status"),
              value: shipment.status ?? '',
            ),
            DetailItemWidget(
              title: context.tr("cargo_type"),
              value: shipment.typeOfCargo ?? '',
            ),
            DetailItemWidget(
              title: context.tr("weight"),
              value: shipment.weight?.toString() ?? '',
            ),
            DetailItemWidget(
              title: context.tr("special_instructions"),
              value: shipment.specialHandlingInstructions ?? context.tr("none"),
            ),
            DetailItemWidget(
              title: context.tr("price"),
              value: shipment.price != null
                  ? shipment.price.toString()
                  : context.tr("not_set"),
            ),
            DetailItemWidget(
              title: context.tr("created_at"),
              value: shipment.createdAt.toString(),
            ),
            verticalSpace(16),
            DetailItemWidget(
              title: context.tr("origin_address"),
              value: shipment.originAddress ?? '',
            ),
            DetailItemWidget(
              title: context.tr("destination_address"),
              value: shipment.destinationAddress ?? '',
            ),
            DetailItemWidget(
              title: context.tr("origin_governorate"),
              value: shipment.originGovernorate?.name ?? '',
            ),
            DetailItemWidget(
              title: context.tr("destination_governorate"),
              value: shipment.destinationGovernorate?.name ?? '',
            ),
            DetailItemWidget(
              title: context.tr("origin_center"),
              value: shipment.originCenter?.name ?? '',
            ),
            DetailItemWidget(
              title: context.tr("destination_center"),
              value: shipment.destinationCenter?.name ?? '',
            ),
            verticalSpace(16),
            Center(
              child: Text(context.tr("sender"),
                  style: AppTextStyles.font16Bold(context)),
            ),
            verticalSpace(8),
            DetailItemWidget(
              title: context.tr("name"),
              value: shipment.sender?.name ?? '',
            ),
            DetailItemWidget(
              title: context.tr("email"),
              value: shipment.sender?.email ?? '',
            ),
            DetailItemWidget(
              title: context.tr("phone"),
              value: shipment.sender?.phone ?? '',
            ),
            DetailItemWidget(
              title: context.tr("address"),
              value: shipment.sender?.address ?? '',
            ),
            verticalSpace(16),
            Center(
              child: Text(context.tr("receiver"),
                  style: AppTextStyles.font16Bold(context)),
            ),
            verticalSpace(8),
            DetailItemWidget(
              title: context.tr("name"),
              value: shipment.receiver?.name ?? '',
            ),
            DetailItemWidget(
              title: context.tr("email"),
              value: shipment.receiver?.email ?? '',
            ),
            DetailItemWidget(
              title: context.tr("phone"),
              value: shipment.receiver?.phone ?? '',
            ),
            DetailItemWidget(
              title: context.tr("address"),
              value: shipment.receiver?.address ?? '',
            ),
            verticalSpace(20),
            Center(
              child: QrImageView(
                data: qrRawString,
                version: QrVersions.auto,
                size: 250.0,
                backgroundColor: Colors.white,
              ),
            ),
            verticalSpace(20),
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
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    if (shipment.groupId != null) {
                      context.pushNamed(
                        Routes.checkpointsScreen,
                        arguments: shipment.groupId,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(context
                                .tr("your_shipment_will_be_on_its_way_soon."))),
                      );
                    }
                  },
                  icon: Icon(
                    Icons.location_pin,
                    size: 40,
                    color: AppColors.primaryOrange,
                  ),
                ),
              ),
            ),
            verticalSpace(20),
          ],
        ),
      ),
    );
  }
}
