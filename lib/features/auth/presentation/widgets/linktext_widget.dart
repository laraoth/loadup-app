import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loadup/core/constant/text_styles.dart';

class LinkTextWidget extends StatelessWidget {
  final String normalText;
  final String linkText;
  final VoidCallback onTap;

  const LinkTextWidget({
    super.key,
    required this.normalText,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: normalText,
            style: AppTextStyles.font14Grey(context),
          ),
          TextSpan(
            text: linkText,
            style: AppTextStyles.font14Regular(context).copyWith(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
