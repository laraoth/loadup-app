import 'package:flutter/material.dart';

class ActivityItemWidget extends StatelessWidget {
  final String code;
  final String status;
  final Color statusColor;
  final Color textColor;

  const ActivityItemWidget({
    super.key,
    required this.code,
    required this.status,
    required this.statusColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.local_shipping, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(child: Text(code)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(color: textColor, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
