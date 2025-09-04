import 'package:flutter/material.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/translation_extension.dart';

class ShipmentActionsWidget extends StatelessWidget {
  final VoidCallback onSendTap;
  final VoidCallback onReceiveTap;

  const ShipmentActionsWidget({
    super.key,
    required this.onSendTap,
    required this.onReceiveTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onSendTap,
            child: Card(
              color: AppColors.surface(context),
              elevation: 6, // زيادة الظل
              shadowColor: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Icon(
                      Icons.arrow_circle_up,
                      color: AppColors.primary(context),
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.tr("send_shipment"),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.font14Regular(context)
                          .copyWith(color: AppColors.text(context)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: onReceiveTap,
            child: Card(
              color: AppColors.surface(context),
              elevation: 6,
              shadowColor: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Icon(
                      Icons.arrow_circle_down,
                      color: AppColors.primary(context),
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.tr("receive_shipment"),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.font14Regular(context)
                          .copyWith(color: AppColors.text(context)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
