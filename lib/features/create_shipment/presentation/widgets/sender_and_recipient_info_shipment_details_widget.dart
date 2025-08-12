import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/features/create_shipment/logic/cubit/centers_cubit.dart';
import 'package:loadup/features/create_shipment/logic/cubit/governorates_cubit.dart';
import 'package:loadup/features/create_shipment/logic/cubit/shipment_request_cubit.dart';
import 'package:loadup/features/create_shipment/logic/cubit/users_cubit.dart';
import 'package:loadup/core/public_widgets/text_field_widget.dart';
import 'package:loadup/core/public_widgets/button_widget.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/spacing.dart';

// استورد موديلاتك هنا بشكل صحيح
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
          // ... حقول أخرى هنا ...
          verticalSpace(24),
          TextFieldWidget(
            controller: shipmentCubit.typeOfCargoController,
            hintText: 'Type of Cargo',
            labelText: 'Type of Cargo',
            obscureText: false,
          ),
          verticalSpace(24),
          TextFieldWidget(
            controller: shipmentCubit.weightController,
            hintText: 'Weight (KG)',
            labelText: 'Weight (KG)',
            obscureText: false,
            keyboardType: TextInputType.number,
          ),

          // المستلم
          GestureDetector(
            onTap: () async {
              // استدعاء الشاشة عن طريق pushNamed وانتظار النتيجة
              final selected = await Navigator.pushNamed(
                context,
                Routes.userSelectionScreen,
              ) as UserDatum?; // هنا نوع UserDatum صريح

              if (selected != null) {
                usersCubit.selectedReciverId = selected.id;
                usersCubit.recieverController.text = selected.name;
                shipmentCubit.selectedReceiverId = selected.id;
              }
            },
            child: AbsorbPointer(
              child: TextFieldWidget(
                controller: usersCubit.recieverController,
                hintText: 'Select Receiver',
                labelText: 'Receiver',
                obscureText: false,
              ),
            ),
          ),
          verticalSpace(24),

          // المحافظة الأصل
          GestureDetector(
            onTap: () async {
              final selected = await Navigator.pushNamed(
                context,
                Routes.governorateSelectionScreen,
                arguments: true, // إذا بتستخدم isOrigin كـ arg
              ) as GovernorateDatum?; // نوع صريح

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
                hintText: 'Select Origin Governorate',
                labelText: 'Origin Governorate',
                obscureText: false,
              ),
            ),
          ),
          verticalSpace(24),

          // المحافظة الوجهة
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
                hintText: 'Select Destination Governorate',
                labelText: 'Destination Governorate',
                obscureText: false,
              ),
            ),
          ),
          verticalSpace(24),

          // مركز الانطلاق
          GestureDetector(
            onTap: () async {
              final selected = await Navigator.pushNamed(
                context,
                Routes.centerSelectionScreen,
                arguments: true,
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
              final selected = await Navigator.pushNamed(
                context,
                Routes.centerSelectionScreen,
                arguments: false,
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
                hintText: 'Select Destination Center',
                labelText: 'Destination Center',
                obscureText: false,
              ),
            ),
          ),

          // باقي الحقول العادية
          verticalSpace(24),
          TextFieldWidget(
            controller: shipmentCubit.originAddressController,
            hintText: 'Origin Address',
            labelText: 'Origin Address',
            obscureText: false,
          ),
          verticalSpace(24),
          TextFieldWidget(
            controller: shipmentCubit.destinationAddressController,
            hintText: 'Destination Address',
            labelText: 'Destination Address',
            obscureText: false,
          ),
          verticalSpace(24),
          TextFieldWidget(
            controller: shipmentCubit.specialInstructionsController,
            hintText: 'Special Handling Instructions',
            labelText: 'Special Handling Instructions',
            obscureText: false,
          ),
          verticalSpace(40),

          ButtonWidget(
            title: "Confirm",
            onTap: () {
              if (shipmentCubit.formKey.currentState!.validate()) {
                shipmentCubit.shipmentrequest();
              }
            },
            textStyle: AppTextStyles.font24WhiteBold,
          )
        ],
      ),
    );
  }
}
