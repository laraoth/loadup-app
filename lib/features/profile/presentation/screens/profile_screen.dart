import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/core/public_widgets/custom_bottom_navigation_bar.dart';
import 'package:loadup/core/public_widgets/loading_widget.dart';
import 'package:loadup/core/routing/routes.dart';
import 'package:loadup/features/auth/logic/cubit/logout_cubit.dart';
import 'package:loadup/features/auth/logic/cubit/logout_state.dart';
import 'package:loadup/features/profile/logic/cubit/profile_cubit.dart';
import 'package:loadup/features/profile/presentation/widgets/profile_actions_widget.dart';
import 'package:loadup/features/profile/presentation/widgets/profile_header_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileCubit>().getprofile();

    return BlocListener<LogoutCubit, LogoutState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logged out successfully')),
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.loginScreen,
            (route) => false,
          );
        } else if (state is LogoutFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Logout failed: ${state.errorMessage}')),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.lightBackground,
        // bottomNavigationBar: const CustomBottomNavigationBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoading) {
                        return LoadingWidget();
                      } else if (state is ProfileError) {
                        return Text(
                          'Error: ${state.error}',
                          style: const TextStyle(color: Colors.red),
                        );
                      } else if (state is ProfileSuccess) {
                        final profile = state.profileModel.data;
                        return ProfileHeaderWidget(
                          name: profile.name,
                          email: profile.email,
                        );
                      }
                      // الحالة الافتراضية لو ما في state معين
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                verticalSpace(20),
                ProfileActionsWidget(),
                verticalSpace(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
