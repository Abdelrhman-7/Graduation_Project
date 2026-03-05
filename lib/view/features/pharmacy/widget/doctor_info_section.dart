import 'package:flutter/material.dart';
import 'package:graduation_project/controller/business_logic-layer/pharmacy_state.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

class DoctorInfoSection extends StatelessWidget {
  final PharmacyLoaded state;

  const DoctorInfoSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            // ignore: deprecated_member_use
            backgroundColor: ColorsManager.purble.withOpacity(0.2),
            child: const Icon(Icons.person, color: ColorsManager.purble),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.prescription.doctorName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                state.prescription.doctorSpecialty,
                style: const TextStyle(
                  fontSize: 12,
                  color: ColorsManager.lightGray,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
