import 'package:flutter/material.dart';
import 'package:graduation_project/models/model/doctor_model.dart';
import 'package:graduation_project/shered_widgites/custom_bouttm/custom_button.dart';
import 'package:graduation_project/shered_widgites/custom_rating_stars/doctor_rating_stars.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

/// Doctor card widget displaying doctor info, rating, availability and action buttons.
class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  final VoidCallback onViewProfile;
  final VoidCallback onBook;

  const DoctorCard({
    super.key,
    required this.doctor,
    required this.onViewProfile,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  // ignore: deprecated_member_use
                  color: ColorsManager.purble.withOpacity(0.12),
                ),
                child: Center(
                  child: Text(
                    doctor.name.split(' ').map((e) => e[0]).take(2).join(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.purble,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. ${doctor.name}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      doctor.specialty,
                      style: const TextStyle(
                        fontSize: 13,
                        color: ColorsManager.lightGray,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    DoctorRatingStars(rating: doctor.rating, starSize: 15),
                  ],
                ),
              ),
              // Available badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      doctor.availableDay,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 14,
                color: ColorsManager.lightGray,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  doctor.hospital,
                  style: const TextStyle(
                    fontSize: 12,
                    color: ColorsManager.lightGray,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '(${doctor.reviewCount} reviews)',
                style: const TextStyle(
                  fontSize: 11,
                  color: ColorsManager.lightGray,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'View Profile',
                  onPressed: onViewProfile,
                  // ignore: deprecated_member_use
                  backgroundColor: ColorsManager.purble.withOpacity(0.1),
                  textColor: ColorsManager.purble,
                  height: 42,
                  borderRadius: 12,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomButton(
                  text: 'Book Now',
                  onPressed: onBook,
                  backgroundColor: ColorsManager.purble,
                  textColor: Colors.white,
                  height: 42,
                  borderRadius: 12,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
