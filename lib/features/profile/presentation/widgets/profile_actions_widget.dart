import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/helpers/extentions.dart';
import 'package:loadup/core/routing/routes.dart';
import 'package:loadup/features/auth/logic/cubit/logout_cubit.dart';
import 'package:loadup/features/auth/logic/cubit/logout_state.dart';
import 'package:loadup/features/auth/presentation/widgets/logout_widget.dart';
import 'package:loadup/core/helpers/translation_extension.dart';
import 'package:loadup/core/constant/colors.dart';

class ProfileActionsWidget extends StatelessWidget {
  const ProfileActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> actions = [
      {
        'title': context.tr("edit_profile"),
        'onTap': () {
          context.pushNamed(Routes.editprofileScreen);
        }
      },
      {
        'title': context.tr("change_password"),
        'onTap': () {
          context.pushNamed(Routes.resetpasswordScreen);
        }
      },
      {
        'title': context.tr("complaints"),
        'onTap': () {
          context.pushNamed(Routes.complaintsScreenSelector);
        }
      },
    ];

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ...actions.map((action) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Material(
              borderRadius: BorderRadius.circular(12),
              elevation: 2,
              color: AppColors.cardBackground(context),
              child: ListTile(
                minVerticalPadding: 24.h,
                title: Text(
                  action['title'] as String,
                  style: TextStyle(color: AppColors.text(context)),
                ),
                trailing: Icon(Icons.arrow_forward_ios,
                    size: 16, color: AppColors.icon(context)),
                onTap: action['onTap'] as void Function()?,
              ),
            ),
          );
        }).toList(),
        SizedBox(height: 16.h),
        BlocListener<LogoutCubit, LogoutState>(
          listener: (context, state) {
            if (state is LogoutSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.tr("logged_out"))),
              );
              context.pushNamed(Routes.loginScreen);
            } else if (state is LogoutFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        '${context.tr("logout_failed")}: ${state.errorMessage}')),
              );
            }
          },
          child: LogoutWidget(),
        ),
      ],
    );
  }
}
