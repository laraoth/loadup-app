// lib/features/home/presentation/screens/home_page_screen.dart
import 'package:flutter/material.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/helpers/extentions.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/core/public_widgets/custom_bottom_navigation_bar.dart';
import 'package:loadup/core/routing/routes.dart';

import 'package:loadup/features/home/presentation/widgets/home_app_bar_widget.dart';
import 'package:loadup/features/home/presentation/widgets/recent_activities_widget.dart';
import 'package:loadup/core/public_widgets/search_bar_widget.dart';
import 'package:loadup/features/home/presentation/widgets/wallet_card_widget.dart';
import 'package:loadup/features/home/presentation/widgets/shipment_actions_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeAppBarWidget(userName: "John Doe"),
              verticalSpace(20),
              const SearchBarWidget(),
              verticalSpace(20),
              const WalletCardWidget(balance: "\$54,023"),
              verticalSpace(20),
              ShipmentActionsWidget(
                onSendTap: () {},
                onReceiveTap: () {},
              ),
              verticalSpace(20),
              RecentActivitiesListWidget(
                activities: const [
                  ActivityItemData(
                    code: '1234567890AB',
                    status: 'On Process',
                    statusColor: Color(0xFFD1E7FF),
                    textColor: Color(0xFF007BFF),
                  ),
                  ActivityItemData(
                    code: '5566778899AB',
                    status: 'Cancelled',
                    statusColor: Color(0xFFFFD1D1),
                    textColor: Color(0xFFFF0000),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
      ),
    );
  }
}
