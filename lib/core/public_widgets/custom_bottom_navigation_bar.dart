import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/di/dependency_injection.dart';
import 'package:loadup/features/auth/logic/cubit/logout_cubit.dart';
import 'package:loadup/features/home/presentation/screens/home_screen.dart';
import 'package:loadup/features/my_shipping/logic/cubit/sent_shipments_cubit.dart';
import 'package:loadup/features/my_shipping/presentation/screens/sent_shipments_screen.dart';
import 'package:loadup/features/profile/logic/cubit/profile_cubit.dart';
import 'package:loadup/features/profile/presentation/screens/profile_screen.dart';
import 'package:loadup/features/wallet/presentation/screens/wallet_screen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late int _selectedIndex;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;

    _screens = [
      const HomeScreen(),
      BlocProvider(
        create: (_) => getIt<SentShipmentsCubit>()..getshipments(),
        child: const MyShippingScreen(),
      ),
      const WalletScreen(),
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<ProfileCubit>()..getprofile()),
          BlocProvider(create: (_) => getIt<LogoutCubit>()),
        ],
        child: const ProfileScreen(),
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryOrange,
        unselectedItemColor: AppColors.grey,
        showUnselectedLabels: true,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping_outlined),
            activeIcon: Icon(Icons.local_shipping),
            label: "My Shipping",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            activeIcon: Icon(Icons.account_balance_wallet),
            label: "Wallet",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
