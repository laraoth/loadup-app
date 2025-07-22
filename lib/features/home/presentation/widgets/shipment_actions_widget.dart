import 'package:flutter/material.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';

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
              color: AppColors.pureWhite,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    const Icon(
                      Icons.arrow_circle_up,
                      color: AppColors.primaryOrange,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Send a\nShipment',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.font14BlackRegular,
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
              color: AppColors.pureWhite,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    const Icon(
                      Icons.arrow_circle_down,
                      color: AppColors.primaryOrange,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Receive a\nShipment',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.font14BlackRegular,
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
