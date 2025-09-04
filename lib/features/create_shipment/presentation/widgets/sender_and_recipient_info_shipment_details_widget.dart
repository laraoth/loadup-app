import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/core/helpers/translation_extension.dart';
import 'package:loadup/features/create_shipment/logic/cubit/centers_cubit.dart';
import 'package:loadup/features/create_shipment/logic/cubit/governorates_cubit.dart';
import 'package:loadup/features/create_shipment/logic/cubit/shipment_request_cubit.dart';
import 'package:loadup/features/create_shipment/logic/cubit/users_cubit.dart';
import 'package:loadup/core/public_widgets/text_field_widget.dart';
import 'package:loadup/core/public_widgets/button_widget.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/features/create_shipment/data/models/users_model.dart';
import 'package:loadup/features/create_shipment/data/models/governorates_model.dart';
import 'package:loadup/features/create_shipment/data/models/centers_model.dart';

import 'package:loadup/core/routing/routes.dart';

class SenderAndRecipientInfoShipmentDetailsWidget extends StatelessWidget {
  const SenderAndRecipientInfoShipmentDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final shipmentCubit = context.read<ShipmentRequestCubit>();
    final usersCubit = context.read<UsersCubit>();
    final centersCubit = context.read<CentersCubit>();
    final governoratesCubit = context.read<GovernoratesCubit>();

    return Form(
      key: shipmentCubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(24),

          /// نوع البضاعة
          TextFieldWidget(
            controller: shipmentCubit.typeOfCargoController,
            hintText: context.tr('type_of_cargo'),
            labelText: context.tr('type_of_cargo'),
            obscureText: false,
          ),
          verticalSpace(24),

          /// الوزن
          TextFieldWidget(
            controller: shipmentCubit.weightController,
            hintText: context.tr('weight'),
            labelText: context.tr('weight'),
            obscureText: false,
            keyboardType: TextInputType.number,
          ),
          verticalSpace(24),

          /// المستلم
          GestureDetector(
            onTap: () async {
              final selected = await Navigator.pushNamed(
                context,
                Routes.userSelectionScreen,
              ) as UserDatum?;

              if (selected != null) {
                usersCubit.selectedReciverId = selected.id;
                usersCubit.recieverController.text = selected.name;
                shipmentCubit.selectedReceiverId = selected.id;
              }
            },
            child: AbsorbPointer(
              child: TextFieldWidget(
                controller: usersCubit.recieverController,
                hintText: context.tr('select_receiver'),
                labelText: context.tr('receiver'),
                obscureText: false,
              ),
            ),
          ),
          verticalSpace(24),

          /// المحافظة الأصل
          GestureDetector(
            onTap: () async {
              final selected = await Navigator.pushNamed(
                context,
                Routes.governorateSelectionScreen,
                arguments: true,
              ) as GovernorateDatum?;

              if (selected != null) {
                governoratesCubit.selectedOriginGovernorateId = selected.id;
                governoratesCubit.originGovernorateController.text =
                    selected.name;
                shipmentCubit.selectedOriginGovernorateId = selected.id;
              }
            },
            child: AbsorbPointer(
              child: TextFieldWidget(
                controller: governoratesCubit.originGovernorateController,
                hintText: context.tr('select_origin_governorate'),
                labelText: context.tr('origin_governorate'),
                obscureText: false,
              ),
            ),
          ),
          verticalSpace(24),

          /// المحافظة الوجهة
          GestureDetector(
            onTap: () async {
              final selected = await Navigator.pushNamed(
                context,
                Routes.governorateSelectionScreen,
                arguments: false,
              ) as GovernorateDatum?;

              if (selected != null) {
                governoratesCubit.selectedDestinationGovernorateId =
                    selected.id;
                governoratesCubit.destinationGovernorateController.text =
                    selected.name;
                shipmentCubit.selectedDestinationGovernorateId = selected.id;
              }
            },
            child: AbsorbPointer(
              child: TextFieldWidget(
                controller: governoratesCubit.destinationGovernorateController,
                hintText: context.tr('select_destination_governorate'),
                labelText: context.tr('destination_governorate'),
                obscureText: false,
              ),
            ),
          ),
          verticalSpace(24),

// مركز الانطلاق
          // مركز الانطلاق
          GestureDetector(
            onTap: () async {
              if (shipmentCubit.selectedOriginGovernorateId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please select origin governorate first"),
                  ),
                );
                return;
              }

              final selected = await Navigator.pushNamed(
                context,
                Routes.centerSelectionScreen,
                arguments: {
                  'isOrigin': true,
                  'governorateId': shipmentCubit.selectedOriginGovernorateId,
                },
              ) as CenterDatum?;

              if (selected != null) {
                centersCubit.selectedOriginCenterId = selected.id;
                centersCubit.originCenterController.text = selected.name;
                shipmentCubit.selectedOriginCenterId = selected.id;
              }
            },
            child: AbsorbPointer(
              child: TextFieldWidget(
                controller: centersCubit.originCenterController,
                hintText: 'Select Origin Center',
                labelText: 'Origin Center',
                obscureText: false,
              ),
            ),
          ),

          verticalSpace(24),

// مركز الوجهة
          GestureDetector(
            onTap: () async {
              if (shipmentCubit.selectedDestinationGovernorateId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text("Please select destination governorate first"),
                  ),
                );
                return;
              }

              final selected = await Navigator.pushNamed(
                context,
                Routes.centerSelectionScreen,
                arguments: {
                  'isOrigin': false,
                  'governorateId':
                      shipmentCubit.selectedDestinationGovernorateId,
                },
              ) as CenterDatum?;

              if (selected != null) {
                centersCubit.selectedDestinationCenterId = selected.id;
                centersCubit.destinationCenterController.text = selected.name;
                shipmentCubit.selectedDestinationCenterId = selected.id;
              }
            },
            child: AbsorbPointer(
              child: TextFieldWidget(
                controller: centersCubit.destinationCenterController,
                hintText: context.tr('select_destination_center'),
                labelText: context.tr('destination_center'),
                obscureText: false,
              ),
            ),
          ),

          verticalSpace(24),

          /// باقي الحقول
          TextFieldWidget(
            controller: shipmentCubit.originAddressController,
            hintText: context.tr('origin_address'),
            labelText: context.tr('origin_address'),
            obscureText: false,
          ),
          verticalSpace(24),
          TextFieldWidget(
            controller: shipmentCubit.destinationAddressController,
            hintText: context.tr('destination_address'),
            labelText: context.tr('destination_address'),
            obscureText: false,
          ),
          verticalSpace(24),
          TextFieldWidget(
            controller: shipmentCubit.specialInstructionsController,
            hintText: context.tr('special_instructions'),
            labelText: context.tr('special_instructions'),
            obscureText: false,
          ),
          verticalSpace(40),

          /// زر التأكيد
          ButtonWidget(
            title: context.tr("confirm"),
            onTap: () {
              if (shipmentCubit.formKey.currentState!.validate()) {
                shipmentCubit.shipmentrequest();
              }
            },
            textStyle: AppTextStyles.font24Bold(context),
          )
        ],
      ),
    );
  }
}
