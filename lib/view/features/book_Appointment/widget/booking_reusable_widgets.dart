import 'package:flutter/material.dart';
import 'package:graduation_project/models/model/doctor_model.dart';
import 'package:graduation_project/shered_widgites/custom_rating_stars/doctor_rating_stars.dart';
import '../../../../shered_widgites/custom_text/custom_text.dart';

const Color primaryBlue = Color(0xFF3B82F6);
const Color bgGrey = Color(0xFFF9FAFB);

class BookingDoctorCard extends StatelessWidget {
  final DoctorModel doctor;

  const BookingDoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.04), // Soft shadow
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // ignore: deprecated_member_use
              color: primaryBlue.withOpacity(0.1),
            ),
            child: Center(
              child: CustomText(
                text: doctor.name.split(' ').map((e) => e[0]).take(2).join().toUpperCase(),
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primaryBlue,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Dr. ${doctor.name}',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                const SizedBox(height: 4),
                CustomText(
                  text: doctor.specialty,
                  fontSize: 14,
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    DoctorRatingStars(rating: doctor.rating, starSize: 16),
                    const SizedBox(width: 8),
                    CustomText(
                      text: '(${doctor.reviewCount} reviews)',
                      fontSize: 13,
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: title,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    );
  }
}

class TimeSlotButton extends StatelessWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlotButton({
    super.key,
    required this.time,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? primaryBlue : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: CustomText(
          text: time,
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}

class AppointmentTypeToggle extends StatelessWidget {
  final bool isVideoCall;
  final ValueChanged<bool> onChanged;

  const AppointmentTypeToggle({
    super.key,
    required this.isVideoCall,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildToggleItem(
          title: 'In-Person',
          icon: Icons.person_outline,
          isActive: !isVideoCall,
          onTap: () => onChanged(false),
        ),
        const SizedBox(width: 16),
        _buildToggleItem(
          title: 'Video Call',
          icon: Icons.videocam_outlined,
          isActive: isVideoCall,
          onTap: () => onChanged(true),
        ),
      ],
    );
  }

  Widget _buildToggleItem({
    required String title,
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: isActive ? primaryBlue.withOpacity(0.1) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isActive ? primaryBlue : Colors.grey[300]!,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isActive ? primaryBlue : Colors.grey[600], size: 20),
              const SizedBox(width: 8),
              CustomText(
                text: title,
                color: isActive ? primaryBlue : Colors.grey[600] ?? Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
