import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/extentions.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/core/helpers/translation_extension.dart';
import 'package:loadup/core/routing/routes.dart';
import 'package:loadup/features/my_shipping/data/model/shipment_model.dart';
import 'package:loadup/features/payment/logic/cubit/create_payment_cubit.dart';
import 'package:loadup/features/payment/logic/cubit/create_payment_state.dart';
import 'package:loadup/features/shipment_details/presentation/widgets/detail_Item_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SentShipmentDetailsScreen extends StatelessWidget {
  final ShipmentDatum shipment;

  const SentShipmentDetailsScreen({super.key, required this.shipment});

  @override
  Widget build(BuildContext context) {
    final qrRawString = shipment.qrCode ?? '{}';
    final shipmentStatusNormalized =
        shipment.status?.trim().toLowerCase() ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr("shipment_details"),
          style: AppTextStyles.font18Bold(context),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppColors.surface(context),
        elevation: 1,
      ),
      body: BlocConsumer<ApprovePriceCubit, ApprovePriceState>(
        listener: (context, state) {
          if (state is ApprovePriceSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.approvePriceModel.message)),
            );
          } else if (state is ApprovePriceError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// --- معلومات أساسية ---
                DetailItemWidget(
                    title: context.tr("shipment_id"),
                    value: shipment.id.toString()),
                DetailItemWidget(
                    title: context.tr("shipment_code"),
                    value: shipment.shipmentCode ?? ''),
                DetailItemWidget(
                    title: context.tr("status"), value: shipment.status ?? ''),
                DetailItemWidget(
                    title: context.tr("cargo_type"),
                    value: shipment.typeOfCargo ?? ''),
                DetailItemWidget(
                    title: context.tr("weight"),
                    value: shipment.weight?.toString() ?? ''),
                DetailItemWidget(
                    title: context.tr("special_instructions"),
                    value: shipment.specialHandlingInstructions ??
                        context.tr("none")),
                DetailItemWidget(
                    title: context.tr("created_at"),
                    value: shipment.createdAt.toString()),

                verticalSpace(16),

                DetailItemWidget(
                  title: context.tr("price"),
                  value: shipment.price != null
                      ? shipment.price.toString()
                      : context.tr("not_set"),
                ),

                verticalSpace(16),

                if (shipmentStatusNormalized == "pending customer approval")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          final pageContext = context;
                          showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return AlertDialog(
                                title: Text(context.tr("confirm_payment")),
                                content: Text(context.tr(
                                    "you_will_pay_the_amount_for_this_shipment")),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(dialogContext),
                                    child: Text(context.tr("cancel")),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(dialogContext);
                                      pageContext
                                          .read<ApprovePriceCubit>()
                                          .approvePrice(shipment.id!);
                                    },
                                    child: Text(context.tr("confirm")),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.w, vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: state is ApprovePriceLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2)
                            : Text(
                                context.tr("accept price"),
                                style: AppTextStyles.font16Bold(context),
                              ),
                      ),
                    ],
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
                                content: Text(context.tr(
                                    "your_shipment_will_be_on_its_way_soon."))),
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
              ],
            ),
          );
        },
      ),
    );
  }
}
