import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/core/resources/colors_manager.dart';

// ignore: must_be_immutable
class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isBackButton = false,
  });
  final VoidCallback onPressed;
  String label;
  bool isBackButton;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        side: BorderSide(width: 2.w, color: ColorsManager.yellow),
        backgroundColor: isBackButton
            ? ColorsManager.black
            : ColorsManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        fixedSize: Size(398.w, 55.h),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: isBackButton ? ColorsManager.purble : ColorsManager.black,
        ),
      ),
    );
  }
}
