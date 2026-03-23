import 'package:flutter/material.dart';
import 'package:graduation_project/models/model/doctor_model.dart';
import 'package:graduation_project/shered_widgites/custom_text/custom_text.dart';
import 'booking_reusable_widgets.dart';

class SuccessIndicator extends StatelessWidget {
  const SuccessIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    const successGreen = Color(0xFF4CAF50);
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // ignore: deprecated_member_use
        color: successGreen.withOpacity(0.1),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: successGreen.withOpacity(0.3),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: successGreen,
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 40),
        ),
      ),
    );
  }
}

class SuccessDoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  const SuccessDoctorCard({super.key, required this.doctor});

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
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // ignore: deprecated_member_use
              color: primaryBlue.withOpacity(0.1),
            ),
            child: Center(
              child: CustomText(
                text: doctor.name.split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join().toUpperCase(),
                fontSize: 20,
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                const SizedBox(height: 4),
                CustomText(
                  text: doctor.specialty,
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppointmentDetailsCard extends StatelessWidget {
  final String dateStr;
  final String timeStr;
  final String locationStr;

  const AppointmentDetailsCard({
    super.key,
    required this.dateStr,
    required this.timeStr,
    required this.locationStr,
  });

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
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailRow(Icons.calendar_today_outlined, 'Date & Time', '$dateStr\n$timeStr'),
          const Divider(height: 32),
          _buildDetailRow(Icons.location_on_outlined, 'Location', locationStr),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: primaryBlue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: primaryBlue, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
              const SizedBox(height: 6),
              CustomText(
                text: value,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
