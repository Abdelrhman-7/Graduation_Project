import 'package:flutter/material.dart';
import 'package:graduation_project/models/model/doctor_model.dart';
import 'package:graduation_project/shered_widgites/custom_bouttm/custom_button.dart';
import 'package:graduation_project/shered_widgites/custom_text/custom_text.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';
import 'package:graduation_project/view/features/book_Appointment/view/book_Appointment.dart';
import '../widget/doctor_details_widgets.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorDetailsScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    // Assuming 10+ years for UI aesthetic demo
    final String experience = '10+';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom Back Button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: ColorsManager.purble,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Title and specialty
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Dr. ${doctor.name}',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.black,
                        ),
                        const SizedBox(height: 8),
                        CustomText(
                          text: doctor.specialty,
                          fontSize: 16,
                          color: ColorsManager.lightGray,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: ColorsManager.purble.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      color: ColorsManager.purble,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Stats Row
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DoctorStatItem(
                      icon: Icons.group,
                      value: '${doctor.reviewCount}+',
                      label: 'Patients',
                      baseColor: Colors.blue,
                    ),
                    DoctorStatItem(
                      icon: Icons.work_history,
                      value: '$experience Yrs',
                      label: 'Experience',
                      baseColor: Colors.green,
                    ),
                    DoctorStatItem(
                      icon: Icons.star,
                      value: '${doctor.rating}',
                      label: 'Rating',
                      baseColor: Colors.orange,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // About Section
              const SizedBox(height: 32),

              // Working Time
              const CustomText(
                text: 'Working Time',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorsManager.black,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            // ignore: deprecated_member_use
                            color: Colors.green.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.access_time,
                            color: Colors.green,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const CustomText(
                          text: 'Mon - Fri, 09:00 AM - 05:00 PM',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: ColorsManager.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 120), // Padding to avoid FAB overlap
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: CustomButton(
          text: 'Book Appointment',
          backgroundColor: ColorsManager.purble,
          textColor: Colors.white,
          height: 60,
          borderRadius: 20,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookAppointmentScreen(doctor: doctor),
              ),
            );
          },
        ),
      ),
    );
  }
}
