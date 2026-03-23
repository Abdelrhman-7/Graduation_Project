import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/shered_widgites/custom_text/custom_text.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

class CalendarGridSection extends StatelessWidget {
  const CalendarGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomText(
              text: 'September 2023',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ColorsManager.black,
            ),
            Row(
              children: [
                Icon(Icons.chevron_left_rounded, color: ColorsManager.lightGray, size: 24.w),
                SizedBox(width: 16.w),
                Icon(Icons.chevron_right_rounded, color: ColorsManager.black, size: 24.w),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'].map((day) => 
            SizedBox(
              width: 40.w,
              child: Center(
                child: CustomText(
                  text: day,
                  fontSize: 13,
                  color: ColorsManager.lightGray,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ).toList(),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDayCell(day: '4', hasIndicator: true),
            _buildDayCell(day: '5', isSelected: true, hasIndicator: true),
            _buildDayCell(day: '6', hasIndicator: true),
            _buildDayCell(day: '7', hasIndicator: false),
            _buildDayCell(day: '8', hasIndicator: true),
            _buildDayCell(day: '9', hasIndicator: false),
            _buildDayCell(day: '10', hasIndicator: false),
          ],
        ),
      ],
    );
  }

  Widget _buildDayCell({required String day, bool isSelected = false, bool hasIndicator = false}) {
    return SizedBox(
      width: 40.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: isSelected ? ColorsManager.primaryBlue : Colors.transparent,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: CustomText(
              text: day,
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? ColorsManager.white : ColorsManager.black,
            ),
          ),
          SizedBox(height: 6.h),
          Container(
            width: 4.r,
            height: 4.r,
            decoration: BoxDecoration(
              color: hasIndicator ? ColorsManager.primaryBlue : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
