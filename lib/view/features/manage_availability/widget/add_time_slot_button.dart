import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/shered_widgites/custom_text/custom_text.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

class AddTimeSlotButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddTimeSlotButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: ColorsManager.primaryBlue.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_rounded, color: ColorsManager.primaryBlue, size: 20.w),
            SizedBox(width: 8.w),
            const CustomText(
              text: 'Add Time Slot',
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: ColorsManager.primaryBlue,
            ),
          ],
        ),
      ),
    );
  }
}
