import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/features/complaints/presentation/widgets/complaints_List_widget.dart';

class ComplaintsViewScreen extends StatelessWidget {
  const ComplaintsViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Complaints', style: AppTextStyles.font24BlackBold),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                verticalSpace(16),
                ComplaintsListWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
