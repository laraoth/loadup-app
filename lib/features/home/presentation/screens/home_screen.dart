import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/helpers/extentions.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/core/helpers/translation_extension.dart';
import 'package:loadup/core/routing/routes.dart';
import 'package:loadup/features/home/presentation/widgets/home_app_bar_widget.dart';
import 'package:loadup/core/public_widgets/search_bar_widget.dart';
import 'package:loadup/features/home/presentation/widgets/shipment_actions_widget.dart';
import 'package:loadup/features/home/presentation/widgets/recent_activities_widget.dart';
import 'package:loadup/features/profile/logic/cubit/profile_cubit.dart';
import 'package:loadup/features/wallet/logic/cubit/payment_cubit.dart';
import 'package:loadup/features/my_shipping/logic/cubit/sent_shipments_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PaymentsCubit>().fetchPayments();
      context.read<SentShipmentsCubit>().getshipments();
      context.read<ProfileCubit>().getprofile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackground(context),
        elevation: 0,
        title: Text(
          context.tr("home"),
          style: TextStyle(
            color: AppColors.text(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: AppColors.icon(context)),
            onPressed: () {
              context.pushNamed(Routes.settingsScreen);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              const HomeAppBarWidget(),
              verticalSpace(20),

              ShipmentActionsWidget(
                onSendTap: () {
                  context.pushNamed(Routes.shipmentRequestScreen);
                },
                onReceiveTap: () {
                  context.pushNamed(Routes.receivedShipmentsScreen);
                },
              ),
              verticalSpace(50),

              /// Recent Activities
              BlocBuilder<SentShipmentsCubit, SentShipmentsState>(
                builder: (context, state) {
                  if (state is SentShipmentsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SentShipmentsError) {
                    return Text(
                      "${context.tr("error")}: ${state.error}",
                      style: TextStyle(color: AppColors.text(context)),
                    );
                  } else if (state is SentShipmentsSuccess) {
                    final shipments = state.shipmentsModel.data;
                    final lastShipments = shipments.take(4).toList();

                    return RecentActivitiesListWidget(
                      activities: lastShipments.map((s) {
                        return ActivityItemData(
                          code: s.shipmentCode ?? '',
                          status: s.status ?? context.tr("unknown"),
                          statusColor: _getStatusColor(s.status),
                          textColor: _getStatusTextColor(s.status),
                        );
                      }).toList(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'On Process':
        return const Color(0xFFD1E7FF);
      case 'Cancelled':
        return const Color(0xFFFFD1D1);
      case 'Delivered':
        return const Color(0xFFD1FFD8);
      default:
        return Colors.grey.shade700;
    }
  }

  Color _getStatusTextColor(String? status) {
    switch (status) {
      case 'On Process':
        return const Color(0xFF007BFF);
      case 'Cancelled':
        return const Color(0xFFFF0000);
      case 'Delivered':
        return const Color(0xFF00AA44);
      default:
        return AppColors.text(context);
    }
  }
}
