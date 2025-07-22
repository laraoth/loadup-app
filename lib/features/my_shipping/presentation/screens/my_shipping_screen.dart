import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/core/public_widgets/custom_bottom_navigation_bar.dart';
import 'package:loadup/core/public_widgets/search_bar_widget.dart';
import 'package:loadup/features/my_shipping/presentation/widgets/shipment_item_widget.dart';
import 'package:loadup/features/my_shipping/presentation/widgets/shipping_filter_tabs_widget.dart';

class MyShippingScreen extends StatefulWidget {
  const MyShippingScreen({super.key});

  @override
  State<MyShippingScreen> createState() => _MyShippingScreenState();
}

class _MyShippingScreenState extends State<MyShippingScreen> {
  int selectedTabIndex = 0;

  final List<Map<String, String>> allShipments = [
    {'status': 'in transit', 'code': '1234567890AB'},
    {'status': 'Delivered', 'code': '9876543210CD'},
    {'status': 'Cancelled', 'code': '5678901234EF'},
    {'status': 'Delivered', 'code': 'ABC123XYZ456'},
  ];

  List<Map<String, String>> get filteredShipments {
    if (selectedTabIndex == 0) return allShipments;

    final statusFilter =
        ['in transit', 'Delivered', 'Cancelled'][selectedTabIndex - 1];

    return allShipments
        .where((item) => item['status'] == statusFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 1),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text('My Shipping',
                      style: AppTextStyles.font24BlackBold)),
              verticalSpace(20),
              const SearchBarWidget(),
              verticalSpace(20),
              ShippingFilterTabsWidget(
                selectedIndex: selectedTabIndex,
                onTabSelected: (index) {
                  setState(() {
                    selectedTabIndex = index;
                  });
                },
              ),
              verticalSpace(20),
              Expanded(
                child: filteredShipments.isEmpty
                    ? Center(
                        child: Text(
                          "No Shipments Found",
                          style: AppTextStyles.font14GreyRegular,
                        ),
                      )
                    : ListView.separated(
                        itemCount: filteredShipments.length,
                        separatorBuilder: (context, index) => verticalSpace(10),
                        itemBuilder: (context, index) {
                          final shipment = filteredShipments[index];
                          return ShippingItemWidget(
                            status: shipment['status']!,
                            code: shipment['code']!,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
