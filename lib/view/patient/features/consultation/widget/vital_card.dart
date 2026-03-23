import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/shered_widgites/custom_text/custom_text.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

class VitalCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final String? status;
  final Color? statusColor;

  const VitalCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.status,
    this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105.w,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
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
          SizedBox(height: 10.h),
          CustomText(
            text: value,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorsManager.black,
          ),
          SizedBox(height: 4.h),
          CustomText(
            text: label,
            fontSize: 12,
            color: ColorsManager.lightGray,
            fontWeight: FontWeight.w500,
          ),
          if (status != null) ...[
            SizedBox(height: 4.h),
            CustomText(
              text: status!,
              fontSize: 11,
              color: statusColor ?? Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ],
        ],
      ),
    );
  }
}
