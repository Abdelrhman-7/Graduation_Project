import 'package:flutter/material.dart';
import 'package:graduation_project/models/model/doctor_model.dart';
import 'package:graduation_project/shered_widgites/custom_bouttm/custom_button.dart';
import 'package:graduation_project/shered_widgites/custom_text/custom_text.dart';
import '../widget/booking_reusable_widgets.dart';

class BookingSuccessfulScreen extends StatelessWidget {
  final DoctorModel doctor;
  final String dateStr;
  final String timeStr;
  final String locationStr;

  const BookingSuccessfulScreen({
    super.key,
    required this.doctor,
    required this.dateStr,
    required this.timeStr,
    required this.locationStr,
  });

  void _onDoneClicked(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _onAddToCalendarClicked(BuildContext context) {
    // Action for add to calendar
  }

  void _onViewAppointmentsClicked(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    const successGreen = Color(0xFF4CAF50);

    return Scaffold(
      backgroundColor: bgGrey,
      appBar: AppBar(
        backgroundColor: bgGrey,
        elevation: 0,
        leading: const SizedBox.shrink(),
        leadingWidth: 0,
        title: const CustomText(
          text: 'Success',
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        actions: [
          TextButton(
            onPressed: () => _onDoneClicked(context),
            child: const CustomText(
              text: 'Done',
              color: primaryBlue,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            
            // Center Section
            Container(
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
            ),
            const SizedBox(height: 32),
            
            // Text Section
            const CustomText(
              text: 'Booking Confirmed!',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            const SizedBox(height: 12),
            CustomText(
              text: 'Your appointment with Dr. ${doctor.name} has been successfully booked.',
              fontSize: 16,
              color: Colors.black54,
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 32),
            
            // Doctor Card
            BookingDoctorCard(doctor: doctor),
            
            const SizedBox(height: 24),
            
            // Appointment Details
            Container(
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
            ),
            
            const SizedBox(height: 40),
            
            // Secondary Button
            CustomButton(
              text: 'Add to Calendar',
              backgroundColor: Colors.white,
              textColor: primaryBlue,
              side: const BorderSide(color: primaryBlue, width: 1.5),
              height: 56,
              borderRadius: 16,
              onPressed: () => _onAddToCalendarClicked(context),
            ),
            const SizedBox(height: 16),
            
            // Primary Button
            CustomButton(
              text: 'View My Appointments',
              backgroundColor: primaryBlue,
              textColor: Colors.white,
              height: 56,
              borderRadius: 16,
              onPressed: () => _onViewAppointmentsClicked(context),
            ),
            const SizedBox(height: 24),
          ],
        ),
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
