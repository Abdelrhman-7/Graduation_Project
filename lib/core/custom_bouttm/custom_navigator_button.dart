import 'package:flutter/material.dart';
import 'package:graduation_project/core/resources/colors_manager.dart';

class CustomNavigatorButton extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback onPressed;

  const CustomNavigatorButton({
    super.key,
    required this.color,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // ياخد عرض الشاشة كله
      height: 60, // ارتفاع ثابت
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: ColorsManager.white,
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
