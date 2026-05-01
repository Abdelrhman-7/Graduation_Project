import 'package:flutter/material.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

class HomeBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {"label": "Home", "icon": Icons.home_outlined, "activeIcon": Icons.home},
      {
        "label": "Schedule",
        "icon": Icons.calendar_today_outlined,
        "activeIcon": Icons.calendar_today,
      },
      {
        "label": "My Health",
        "icon": Icons.favorite_border,
        "activeIcon": Icons.favorite,
      },
      {
        "label": "Profile",
        "icon": Icons.person_outline,
        "activeIcon": Icons.person,
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isActive = currentIndex == index;
              return GestureDetector(
                onTap: () => onTap(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isActive
                          ? item["activeIcon"] as IconData
                          : item["icon"] as IconData,
                      color: isActive
                          ? ColorsManager.purble
                          : ColorsManager.lightGray,
                      size: 26,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item["label"] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: isActive
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isActive
                            ? ColorsManager.purble
                            : ColorsManager.lightGray,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
