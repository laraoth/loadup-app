// pending_shipments_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/helpers/translation_extension.dart';
import 'package:loadup/core/public_widgets/loading_widget.dart';
import 'package:loadup/features/my_shipping/logic/cubit/pending_shipments_cubit.dart';

import 'package:loadup/features/my_shipping/presentation/widgets/shipment_item_widget.dart';

class PendingShipmentsScreen extends StatefulWidget {
  const PendingShipmentsScreen({super.key});

  @override
  State<PendingShipmentsScreen> createState() => _PendingShipmentsScreenState();
}

class _PendingShipmentsScreenState extends State<PendingShipmentsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PendingShipmentsCubit>().getPendingShipments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr("pending_shipments")),
      ),
      body: BlocBuilder<PendingShipmentsCubit, PendingShipmentsState>(
        builder: (context, state) {
          if (state is PendingShipmentsLoading) {
            return const LoadingWidget();
          } else if (state is PendingShipmentsError) {
            return Center(child: Text(state.error));
          } else if (state is PendingShipmentsSuccess) {
            final shipments = state.shipmentsModel.data;

            if (shipments.isEmpty) {
              return Center(
                child: Text(context.tr("no_pending_shipments")),
              );
            }

            return ListView.builder(
              itemCount: shipments.length,
              itemBuilder: (context, index) {
                final shipment = shipments[index];
                return ShippingItemWidget(
                  code: shipment.shipmentCode ?? '',
                  shipment: shipment,
                  status: Status.PENDING_CUSTOMER_APPROVAL,
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
