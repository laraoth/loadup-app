import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/public_widgets/button_widget.dart';
import 'package:loadup/features/auth/logic/cubit/logout_cubit.dart';
import 'package:loadup/core/helpers/translation_extension.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      title: context.tr("log_out"),
      onTap: () {
        context.read<LogoutCubit>().logout();
      },
      backgroundColor: Colors.red,
      textStyle: AppTextStyles.font24Bold(context),
    );
  }
}
