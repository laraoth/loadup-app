import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/core/helpers/translation_extension.dart';
import 'package:loadup/features/complaints/presentation/widgets/shipment_id_and_description_widget.dart';

class ComplaintsScreen extends StatelessWidget {
  const ComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr("complaints"),
          style: AppTextStyles.font24Bold(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 30.w,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                verticalSpace(24),
                ShipmentIdAndDescriptionWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
