import 'package:flutter/material.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/helpers/extentions.dart';
import 'package:loadup/core/routing/routes.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
  });

  void _navigateTo(BuildContext context, int index) {
    if (index == currentIndex) return;

    final routes = [
      Routes.homeScreen,
      Routes.myShipping,
      Routes.scanScreen,
      Routes.walletScreen,
      Routes.profileScreen,
    ];

    context.pushReplacementNamed(routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: AppColors.primaryOrange,
      unselectedItemColor: AppColors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (index) => _navigateTo(context, index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2), label: 'Package'),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'Scan'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
      ],
    );
  }
}
