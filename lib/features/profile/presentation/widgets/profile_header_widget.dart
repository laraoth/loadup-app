import 'package:flutter/material.dart';
import 'package:loadup/core/constant/text_styles.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final String email;

  const ProfileHeaderWidget({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 70,
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, size: 120, color: Colors.white),
        ),
        const SizedBox(height: 12),
        Text(name, style: AppTextStyles.font18BlackBold),
        const SizedBox(height: 4),
        Text(email, style: AppTextStyles.font14GreyRegular),
      ],
    );
  }
}
