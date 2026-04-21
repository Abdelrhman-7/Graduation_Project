import 'package:flutter/material.dart';
import 'package:graduation_project/models/model/shered_pref_controller/shered_pref_controler.dart';
import '../../../../../shered_widgites/resources/colors_manager.dart';

class ProfileTopSection extends StatelessWidget {
  const ProfileTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  // ignore: deprecated_member_use
                  color: ColorsManager.primaryBlue.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: const CircleAvatar(
                radius: 28,
                backgroundColor: ColorsManager.lightBlue,
                child: Icon(
                  Icons.person,
                  color: ColorsManager.primaryBlue,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Good Morning,',
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorsManager.gray,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                FutureBuilder<String?>(
                  future: SharedPrefController().getEmail(),
                  builder: (context, snapshot) {
                    String name = "Doctor";
                    if (snapshot.hasData && snapshot.data != null) {
                      name = snapshot.data!.split('@').first;
                    }
                    return Text(
                      'Dr. $name',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.black,
                        letterSpacing: -0.5,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: ColorsManager.primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Cardiology',
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorsManager.primaryBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Scaffold.of(context).openEndDrawer();
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorsManager.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: ColorsManager.black,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
