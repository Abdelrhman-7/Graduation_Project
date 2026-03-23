import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/shered_widgites/custom_text/custom_text.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? trailingText;
  final IconData? icon;

  const SectionHeader({
    super.key,
    required this.title,
    this.trailingText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18.w, color: ColorsManager.lightGray),
                SizedBox(width: 8.w),
              ],
              CustomText(
                text: title.toUpperCase(),
                fontSize: 12,
                color: ColorsManager.lightGray,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          if (trailingText != null)
            CustomText(
              text: trailingText!,
              fontSize: 12,
              color: ColorsManager.lightGray,
            ),
        ],
      ),
    );
  }
}
