import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/helpers/extentions.dart';
import 'package:loadup/core/routing/routes.dart';
import 'package:loadup/features/auth/logic/cubit/logout_cubit.dart';
import 'package:loadup/features/auth/logic/cubit/logout_state.dart';
import 'package:loadup/features/auth/presentation/widgets/logout_widget.dart';

class ProfileActionsWidget extends StatelessWidget {
  const ProfileActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> actions = [
      {
        'title': 'Edit Profile',
        'onTap': () {
          context.pushNamed(Routes.editprofileScreen);
        }
      },
      {
        'title': 'Change Password',
        'onTap': () {
          context.pushNamed(Routes.resetpasswordScreen);
        }
      },
      {
        'title': 'Complaints',
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
              color: Colors.white,
              child: ListTile(
                minVerticalPadding: 24.h,
                title: Text(action['title'] as String),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
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
                const SnackBar(content: Text('Logged out successfully')),
              );
              context.pushNamed(Routes.loginScreen);
            } else if (state is LogoutFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Logout failed: ${state.errorMessage}')),
              );
            }
          },
          child: LogoutWidget(),
        ),
      ],
    );
  }
}
