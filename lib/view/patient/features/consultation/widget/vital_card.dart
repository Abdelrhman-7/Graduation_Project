import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/shered_widgites/custom_text/custom_text.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

class VitalCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  /// Unit or status line under the value (e.g. "Normal", "bpm", "Fahrenheit").
  final String? footer;
  final Color? footerColor;

  const VitalCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.footer,
    this.footerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105.w,
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 20.w, color: ColorsManager.lightGray),
          SizedBox(height: 8.h),
          CustomText(
            text: label,
            fontSize: 11,
            color: ColorsManager.lightGray,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 6.h),
          CustomText(
            text: value,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorsManager.black,
          ),
          if (footer != null) ...[
            SizedBox(height: 4.h),
            CustomText(
              text: footer!,
              fontSize: 11,
              color: footerColor ?? ColorsManager.lightGray,
              fontWeight: FontWeight.w600,
            ),
          ],
        ],
      ),
    );
  }
}
