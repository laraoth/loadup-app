import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/core/helpers/translation_extension.dart';

class ShippingFilterTabsWidget extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const ShippingFilterTabsWidget({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  State<ShippingFilterTabsWidget> createState() =>
      _ShippingFilterTabsWidgetState();
}

class _ShippingFilterTabsWidgetState extends State<ShippingFilterTabsWidget> {
  late final List<String> filterTabs;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    filterTabs = [
      context.tr("all"),
      context.tr("draft"),
      context.tr("pending admin approval"),
      context.tr("rejected by admin"),
      context.tr("priced by admin"),
      context.tr("pending customer approval"),
      context.tr("rejected by customer"),
      context.tr("pending payment"),
      context.tr("paid"),
      context.tr("in_transit"),
      context.tr("delivered"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filterTabs.length,
        separatorBuilder: (context, index) => horizontalSpace(10),
        itemBuilder: (context, index) {
          final isSelected = index == widget.selectedIndex;
          return GestureDetector(
            onTap: () => widget.onTabSelected(index),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color.fromARGB(255, 127, 145, 154)
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Center(
                child: Text(
                  filterTabs[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
