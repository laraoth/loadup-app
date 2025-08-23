import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/core/public_widgets/button_widget.dart';
import 'package:loadup/core/public_widgets/loading_widget.dart';
import 'package:loadup/core/public_widgets/text_field_widget.dart';
import 'package:loadup/features/complaints/logic/cubit/create_complaints_cubit.dart';
import 'package:loadup/features/my_shipping/logic/cubit/received_shipments_cubit.dart';

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
    final createcomplaintCubit = context.read<CreateComplaintsCubit>();
    final receivedShipmentsCubit = context.read<ReceivedShipmentsCubit>();
    return Form(
        key: createcomplaintCubit.formKey,
        child: Column(
          children: [
            Text(
              'If you experienced an issue with a shipment, feel free to file a complaint',
              style: AppTextStyles.font14GreyRegular,
            ),
            TextFieldWidget(
              controller: createcomplaintCubit.shipmentidController,
              hintText: 'Enter your shipment id',
              labelText: 'Enter your shipment id',
              obscureText: false,
              readOnly: true,
              onTap: () async {
                final receivedShipmentsCubit =
                    context.read<ReceivedShipmentsCubit>();
                if (receivedShipmentsCubit.state is! ReceivedShipmentsSuccess) {
                  receivedShipmentsCubit.getreceivedshipments();
                }

                showModalBottomSheet(
                  context: context,
                  builder: (_) => BlocProvider.value(
                    value: receivedShipmentsCubit,
                    child: BlocBuilder<ReceivedShipmentsCubit,
                        ReceivedShipmentsState>(
                      builder: (context, state) {
                        if (state is ReceivedShipmentsLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is ReceivedShipmentsSuccess) {
                          return SizedBox(
                            height: 400,
                            child: ListView.builder(
                              itemCount: state.shipmentsModel.data.length,
                              itemBuilder: (context, index) {
                                final shipment =
                                    state.shipmentsModel.data[index];
                                return ListTile(
                                  title: Text(shipment.id.toString()),
                                  onTap: () {
                                    // تعيين الـ id المختار في الكيوبت
                                    createcomplaintCubit.selectShipmentId(
                                        shipment.id!); // id هنا

                                    // تحديث النص في TextField لعرض الكود
                                    createcomplaintCubit.shipmentidController
                                        .text = shipment.id.toString();

                                    Navigator.pop(context);
                                  },
                                );
                              },
                            ),
                          );
                        } else {
                          return const Center(
                              child: Text("No shipments found"));
                        }
                      },
                    ),
                  ),
                );
              },
            ),
            verticalSpace(24),
            SizedBox(
              height: 150.h,
              child: TextFieldWidget(
                controller: createcomplaintCubit.shipmentdescriptionController,
                hintText:
                    'Please describe the issue you faced\nwith this shipment...',
                labelText:
                    'Please describe the issue you faced\nwith this shipment...',
                obscureText: false,
              ),
            ),
            verticalSpace(40),
            BlocConsumer<CreateComplaintsCubit, CreateComplaintsState>(
              listener: (context, state) {
                if (state is CreateComplaintsSuccess) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(state.message)));
                  // context.pushNamed(Routes.customBottomNavigationBar);
                } else if (state is CreateComplaintsError) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                if (state is CreateComplaintsLoading) {
                  return LoadingWidget();
                } else {
                  return ButtonWidget(
                      title: "Send",
                      onTap: () {
                        if (context
                            .read<CreateComplaintsCubit>()
                            .formKey
                            .currentState!
                            .validate()) {
                          context
                              .read<CreateComplaintsCubit>()
                              .createcomplaint();
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
