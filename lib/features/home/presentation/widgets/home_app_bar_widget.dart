import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/translation_extension.dart';
import 'package:loadup/features/profile/logic/cubit/profile_cubit.dart';
import 'package:loadup/core/public_widgets/loading_widget.dart';
import 'package:loadup/core/constant/colors.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(context.tr('hello'), style: AppTextStyles.font18Bold(context)),
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const LoadingWidget();
            } else if (state is ProfileError) {
              return Text(
                context.tr('user'),
                style: AppTextStyles.font18Bold(context)
                    .copyWith(color: AppColors.text(context)),
              );
            } else if (state is ProfileSuccess) {
              final profile = state.profileModel.data;
              return Text(
                profile.name ?? context.tr('user'),
                style: AppTextStyles.font18Bold(context)
                    .copyWith(color: AppColors.text(context)),
              );
            }
            return Text(
              context.tr('user'),
              style: AppTextStyles.font18Bold(context)
                  .copyWith(color: AppColors.text(context)),
            );
          },
        ),
      ],
    );
  }
}
