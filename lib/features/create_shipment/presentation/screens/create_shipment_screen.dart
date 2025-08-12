import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/features/create_shipment/presentation/widgets/sender_and_recipient_info_shipment_details_widget.dart';

class CreateShipmentScreen extends StatelessWidget {
  const CreateShipmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Shipment'),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30.w,
          vertical: 30.w,
        ),
        child: ListView(
          children: [
            Column(
              children: [
                SenderAndRecipientInfoShipmentDetailsWidget(),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
