import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/di/dependency_injection.dart';
import 'package:loadup/core/helpers/translation_extension.dart';
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
    final cardColor = AppColors.surface(context);
    final selectedColor = AppColors.primary(context);
    final unselectedColor = AppColors.text(context);

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: selectedColor,
            unselectedItemColor: unselectedColor,
            backgroundColor: cardColor,
            selectedFontSize: 14,
            unselectedFontSize: 12,
            showUnselectedLabels: true,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon:
                    Icon(Icons.home_outlined, size: 28, color: unselectedColor),
                activeIcon: Icon(Icons.home, size: 30, color: selectedColor),
                label: context.tr('home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_shipping_outlined,
                    size: 28, color: unselectedColor),
                activeIcon:
                    Icon(Icons.local_shipping, size: 30, color: selectedColor),
                label: context.tr('my_shipping'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_outlined,
                    size: 28, color: unselectedColor),
                activeIcon: Icon(Icons.account_balance_wallet,
                    size: 30, color: selectedColor),
                label: context.tr('payments'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline,
                    size: 28, color: unselectedColor),
                activeIcon: Icon(Icons.person, size: 30, color: selectedColor),
                label: context.tr('profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
