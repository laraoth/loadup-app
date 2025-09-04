import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/extentions.dart';
import 'package:loadup/core/routing/routes.dart';
import 'package:loadup/core/helpers/translation_extension.dart';
import 'package:loadup/features/my_shipping/data/model/shipment_model.dart';

enum Status {
  ALL,
  DRAFT,
  PENDING_ADMIN_APPROVAL,
  REJECTED_BY_ADMIN,
  PRICED_BY_ADMIN,
  PENDING_CUSTOMER_APPROVAL,
  REJECTED_BY_CUSTOMER,
  PENDING_PAYMENT,
  PAID,
  IN_TRANSIT,
  DELIVERED,
  UNKNOWN,
}

class ShippingItemWidget extends StatelessWidget {
  final ShipmentDatum shipment;
  final String code;
  final Status status;

  const ShippingItemWidget({
    super.key,
    required this.code,
    required this.status,
    required this.shipment,
  });

  Color getStatusColor(Status status) {
    switch (status) {
      case Status.DRAFT:
        return Colors.grey.shade300;
      case Status.PENDING_ADMIN_APPROVAL:
        return Colors.orange.shade100;
      case Status.REJECTED_BY_ADMIN:
        return Colors.red.shade100;
      case Status.PRICED_BY_ADMIN:
        return Colors.blue.shade100;
      case Status.PENDING_CUSTOMER_APPROVAL:
        return Colors.orange.shade200;
      case Status.REJECTED_BY_CUSTOMER:
        return Colors.red.shade200;
      case Status.PENDING_PAYMENT:
        return Colors.purple.shade100;
      case Status.PAID:
        return Colors.green.shade200;
      case Status.IN_TRANSIT:
        return Colors.blue.shade200;
      case Status.DELIVERED:
        return Colors.green.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  Color getStatusTextColor(Status status) {
    switch (status) {
      case Status.DRAFT:
        return Colors.black87;
      case Status.PENDING_ADMIN_APPROVAL:
        return Colors.orange;
      case Status.REJECTED_BY_ADMIN:
        return Colors.red;
      case Status.PRICED_BY_ADMIN:
        return Colors.blue;
      case Status.PENDING_CUSTOMER_APPROVAL:
        return Colors.deepOrange;
      case Status.REJECTED_BY_CUSTOMER:
        return Colors.redAccent;
      case Status.PENDING_PAYMENT:
        return Colors.purple;
      case Status.PAID:
        return Colors.green;
      case Status.IN_TRANSIT:
        return Colors.blue;
      case Status.DELIVERED:
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  String getStatusText(Status status, BuildContext context) {
    switch (status) {
      case Status.DRAFT:
        return context.tr("draft");
      case Status.PENDING_ADMIN_APPROVAL:
        return context.tr("pending admin approval");
      case Status.REJECTED_BY_ADMIN:
        return context.tr("rejected by admin");
      case Status.PRICED_BY_ADMIN:
        return context.tr("priced by admin");
      case Status.PENDING_CUSTOMER_APPROVAL:
        return context.tr("pending customer approval");
      case Status.REJECTED_BY_CUSTOMER:
        return context.tr("rejected_by_customer");
      case Status.PENDING_PAYMENT:
        return context.tr("pending payment");
      case Status.PAID:
        return context.tr("paid");
      case Status.IN_TRANSIT:
        return context.tr("in_transit");
      case Status.DELIVERED:
        return context.tr("delivered");
      default:
        return context.tr("unknown");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          Routes.sentShipmentDetailsScreen,
          arguments: shipment,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.surface(context),
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
                    "${context.tr("shipment_code")}: $code",
                    style: AppTextStyles.font16Regular(context),
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
                      getStatusText(status, context),
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
