import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/extentions.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/core/helpers/translation_extension.dart';
import 'package:loadup/core/public_widgets/button_widget.dart';
import 'package:loadup/core/public_widgets/loading_widget.dart';
import 'package:loadup/core/public_widgets/text_field_widget.dart';
import 'package:loadup/core/routing/routes.dart';
import 'package:loadup/features/auth/logic/cubit/login_cubit.dart';
import 'package:loadup/features/auth/logic/cubit/login_state.dart';
import 'package:loadup/features/edit_profile/logic/cubit/edit_profile_cubit.dart';

class EditUserInfoWidget extends StatefulWidget {
  const EditUserInfoWidget({super.key});

  @override
  State<EditUserInfoWidget> createState() => _EditUserInfoWidgetState();
}

Future<void> _selectBirthDate(BuildContext context) async {
  context.read<EditProfileCubit>().pickBirthDate(context);
}

class _EditUserInfoWidgetState extends State<EditUserInfoWidget> {
  @override
  Widget build(BuildContext context) {
    final editprofilecubit = context.read<EditProfileCubit>();
    return Form(
        key: editprofilecubit.formKey,
        child: Column(
          children: [
            TextFieldWidget(
              controller: editprofilecubit.nameController,
              hintText: context.tr('name'),
              labelText: context.tr('name'),
              prefixIcon: Icons.person,
              prefixIconColor: AppColors.primaryOrange,
              obscureText: false,
            ),
            verticalSpace(24),
            TextFieldWidget(
              controller: editprofilecubit.emailController,
              hintText: context.tr('email'),
              labelText: context.tr('email'),
              prefixIcon: Icons.email,
              prefixIconColor: AppColors.primaryOrange,
              obscureText: false,
            ),
            verticalSpace(24),
            TextFieldWidget(
              controller: editprofilecubit.phoneController,
              hintText: context.tr('phone_number'),
              labelText: context.tr('phone_number'),
              prefixIcon: Icons.phone,
              prefixIconColor: AppColors.primaryOrange,
              obscureText: false,
            ),
            verticalSpace(40),
            TextFieldWidget(
              controller: editprofilecubit.addressController,
              hintText: context.tr('address'),
              labelText: context.tr('address'),
              prefixIcon: Icons.location_city,
              prefixIconColor: AppColors.primaryOrange,
              obscureText: false,
            ),
            verticalSpace(40),
            BlocBuilder<EditProfileCubit, EditProfileState>(
              builder: (context, state) {
                final selectedBirthDate = editprofilecubit.selectedBirthDate;
                final calculatedAge = editprofilecubit.calculatedAge;
                return InkWell(
                  onTap: () => _selectBirthDate(context),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: context.tr('birth_date'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: Icon(Icons.calendar_today,
                          color: AppColors.primaryOrange),
                    ),
                    child: Text(
                      selectedBirthDate == null
                          ? context.tr('select_your_birth_date')
                          : '${'${selectedBirthDate.toLocal()}'.split(' ')[0]} - ${context.tr('age')}: ${calculatedAge ?? ''}',
                      style: TextStyle(
                        color: selectedBirthDate == null
                            ? Colors.grey
                            : Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
            verticalSpace(40),
            BlocConsumer<EditProfileCubit, EditProfileState>(
              listener: (context, state) {
                if (state is EditProfileSuccess) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(state.message)));
                } else if (state is EditProfileError) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                if (state is EditProfileLoading) {
                  return LoadingWidget();
                } else {
                  return ButtonWidget(
                      title: context.tr("save"),
                      onTap: () {
                        if (context
                            .read<EditProfileCubit>()
                            .formKey
                            .currentState!
                            .validate()) {
                          context.read<EditProfileCubit>().updateprofile();
                        }
                      },
                      textStyle: AppTextStyles.font24Bold(context));
                }
              },
            )
          ],
        ));
  }
}
