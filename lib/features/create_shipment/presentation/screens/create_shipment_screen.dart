import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/core/helpers/translation_extension.dart';
import 'package:loadup/features/create_shipment/logic/cubit/shipment_request_cubit.dart';
import 'package:loadup/features/create_shipment/presentation/widgets/sender_and_recipient_info_shipment_details_widget.dart';

class CreateShipmentScreen extends StatelessWidget {
  const CreateShipmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShipmentRequestCubit, ShipmentRequestState>(
      listener: (context, state) {
        if (state is ShipmentRequestSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
        } else if (state is ShipmentRequestError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.tr('Create Shipment')),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
              vertical: 30.w,
            ),
            child: ListView(
              children: const [
                SenderAndRecipientInfoShipmentDetailsWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
