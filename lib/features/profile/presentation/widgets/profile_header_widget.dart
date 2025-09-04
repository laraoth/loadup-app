import 'package:flutter/material.dart';
import 'package:loadup/core/constant/text_styles.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final String? email;
  final String? profilePhotoUrl;

  const ProfileHeaderWidget({
    super.key,
    required this.name,
    this.email,
    this.profilePhotoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 70,
          backgroundColor: Colors.grey,
          backgroundImage:
              profilePhotoUrl != null ? NetworkImage(profilePhotoUrl!) : null,
          child: profilePhotoUrl == null
              ? const Icon(Icons.person, size: 120, color: Colors.white)
              : null,
        ),
        const SizedBox(height: 12),
        Text(name, style: AppTextStyles.font18Bold(context)),
        const SizedBox(height: 4),
        Text(email ?? '', style: AppTextStyles.font14Grey(context)),
      ],
    );
  }
}
