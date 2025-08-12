import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/extentions.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/core/public_widgets/button_widget.dart';
import 'package:loadup/core/public_widgets/loading_widget.dart';
import 'package:loadup/core/public_widgets/text_field_widget.dart';
import 'package:loadup/core/routing/routes.dart';
import 'package:loadup/features/auth/logic/cubit/login_cubit.dart';
import 'package:loadup/features/auth/logic/cubit/login_state.dart';

class ShipmentIdAndDescriptionWidget extends StatefulWidget {
  const ShipmentIdAndDescriptionWidget({super.key});

  @override
  State<ShipmentIdAndDescriptionWidget> createState() =>
      _ShipmentIdAndDescriptionWidgetState();
}

class _ShipmentIdAndDescriptionWidgetState
    extends State<ShipmentIdAndDescriptionWidget> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    return Form(
        key: loginCubit.formKey,
        child: Column(
          children: [
            Text(
              'If you experienced an issue with a shipment, feel free to file a complaint',
              style: AppTextStyles.font14GreyRegular,
            ),
            TextFieldWidget(
              controller: loginCubit.emailController,
              hintText: 'Enter your shipment id',
              labelText: 'Enter your shipment id',
              obscureText: false,
            ),
            verticalSpace(24),
            SizedBox(
              height: 150.h,
              child: TextFieldWidget(
                controller: loginCubit.passwordController,
                hintText:
                    'Please describe the issue you faced\nwith this shipment...',
                labelText:
                    'Please describe the issue you faced\nwith this shipment...',
                obscureText: false,
              ),
            ),
            verticalSpace(40),
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(state.message)));
                  // context.pushNamed(Routes.customBottomNavigationBar);
                } else if (state is LoginError) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                if (state is LoginLoading) {
                  return LoadingWidget();
                } else {
                  return ButtonWidget(
                      title: "Send",
                      onTap: () {
                        if (context
                            .read<LoginCubit>()
                            .formKey
                            .currentState!
                            .validate()) {
                          context.read<LoginCubit>().login();
                        }
                      },
                      textStyle: AppTextStyles.font24WhiteBold);
                }
              },
            )
          ],
        ));
  }
}
