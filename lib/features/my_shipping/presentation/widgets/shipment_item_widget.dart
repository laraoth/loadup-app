import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/extentions.dart';
import 'package:loadup/core/routing/routes.dart';

enum Status {
  IN_TRANSIT,
  DELIVERED,
  PENDING_FOR_ASSIGNMENT,
  CANCELLED,
  UNKNOWN,
  DRAFT
}

class ShippingItemWidget extends StatelessWidget {
  final String code;
  final Status status;

  const ShippingItemWidget({
    super.key,
    required this.code,
    required this.status,
  });

  Color getStatusColor(Status status) {
    switch (status) {
      case Status.IN_TRANSIT:
        return Colors.blue.shade100;
      case Status.DELIVERED:
        return Colors.green.shade100;
      case Status.PENDING_FOR_ASSIGNMENT:
        return Colors.orange.shade100;
      case Status.DRAFT:
        return Colors.red.shade100;
      default:
        return Colors.grey.shade300;
    }
  }

  Color getStatusTextColor(Status status) {
    switch (status) {
      case Status.IN_TRANSIT:
        return Colors.blue;
      case Status.DELIVERED:
        return Colors.green;
      case Status.PENDING_FOR_ASSIGNMENT:
        return Colors.orange;
      // case Status.CANCELLED:
      //   return Colors.red;
      case Status.DRAFT:
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  String getStatusText(Status status) {
    switch (status) {
      case Status.IN_TRANSIT:
        return 'In Transit';
      case Status.DELIVERED:
        return 'Delivered';
      case Status.PENDING_FOR_ASSIGNMENT:
        return 'Pending';
      case Status.DRAFT:
        return 'draft';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.shipmentDetailsScreen);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade100,
              radius: 25.r,
              child: const Icon(Icons.inventory_2, color: Colors.grey),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shipment Code: $code",
                    style: AppTextStyles.font16BlackRegular,
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: getStatusColor(status),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      getStatusText(status),
                      style: TextStyle(
                        color: getStatusTextColor(status),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
