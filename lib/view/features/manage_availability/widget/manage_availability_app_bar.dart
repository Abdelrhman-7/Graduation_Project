import 'package:flutter/material.dart';
import 'package:graduation_project/shered_widgites/custom_text/custom_text.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

class ManageAvailabilityAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ManageAvailabilityAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsManager.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: ColorsManager.black, size: 20),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const CustomText(
        text: 'Manage Availability',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: ColorsManager.black,
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: const CustomText(
            text: 'Help',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: ColorsManager.purble,
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
