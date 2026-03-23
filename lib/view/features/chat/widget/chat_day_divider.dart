import 'package:flutter/material.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

class ChatDayDivider extends StatelessWidget {
  final String label;

  const ChatDayDivider({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 1, color: Color(0xFFE5E7EB))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: ColorsManager.lightGray,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Expanded(child: Divider(thickness: 1, color: Color(0xFFE5E7EB))),
      ],
    );
  }
}
