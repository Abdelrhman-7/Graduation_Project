import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

enum CustomButtonStyle { solid, bordered, backButton }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final CustomButtonStyle style;
  final bool useScreenUtil;
  final BorderSide? side;
  final Widget? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.width,
    this.borderRadius = 15,
    this.fontSize = 17,
    this.fontWeight = FontWeight.w700,
    this.style = CustomButtonStyle.solid,
    this.useScreenUtil = false,
    this.side,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Determine style properties
    Color effectiveBgColor = backgroundColor ?? ColorsManager.purble;
    Color effectiveTextColor = textColor ?? Colors.white;
    BorderSide? effectiveSide = side;
    double effectiveHeight = height ?? 60;
    double effectiveRadius = borderRadius;
    double effectiveFontSize = fontSize;

    if (style == CustomButtonStyle.backButton) {
      effectiveBgColor = ColorsManager.black;
      effectiveTextColor = ColorsManager.purble;
      effectiveSide = BorderSide(width: 2.w, color: ColorsManager.yellow);
      effectiveRadius = 20;
      effectiveFontSize = 20;
    } else if (style == CustomButtonStyle.bordered) {
      effectiveBgColor = Colors.white;
      effectiveTextColor = ColorsManager.black;
      effectiveSide = BorderSide(width: 2.w, color: ColorsManager.yellow);
      effectiveRadius = 20;
      effectiveFontSize = 20;
    }

    final bool useScaling = useScreenUtil || style != CustomButtonStyle.solid;

    final finalHeight = useScaling ? effectiveHeight.h : effectiveHeight;
    final finalWidth = width != null
        ? (useScaling ? width!.w : width!)
        : double.infinity;
    final finalRadius = useScaling ? effectiveRadius.r : effectiveRadius;
    final finalFontSize = useScaling ? effectiveFontSize.sp : effectiveFontSize;

    Widget childWidget = Text(
      text,
      style: TextStyle(
        color: effectiveTextColor,
        fontWeight: fontWeight,
        fontSize: finalFontSize,
      ),
    );

    if (icon != null) {
      childWidget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          childWidget,
          const SizedBox(width: 10),
          icon!,
        ],
      );
    }

    return SizedBox(
      width: finalWidth,
      height: finalHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBgColor,
          elevation: 0,
          side: effectiveSide,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(finalRadius),
          ),
        ),
        onPressed: onPressed,
        child: childWidget,
      ),
    );
  }
}
