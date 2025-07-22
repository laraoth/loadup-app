import 'package:flutter/material.dart';
import 'package:loadup/core/constant/text_styles.dart';

class HomeAppBarWidget extends StatelessWidget {
  final String userName;
  const HomeAppBarWidget({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Hello, $userName', style: AppTextStyles.font18BlackBold),
        const CircleAvatar(
          radius: 20,
          backgroundColor: Colors.black12,
          child: Icon(Icons.notifications, color: Colors.black),
        ),
      ],
    );
  }
}
