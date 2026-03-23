import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shered_widgites/custom_bouttm/custom_button.dart';
import 'package:graduation_project/shered_widgites/custom_text/custom_text.dart';
import '../manager/book_appointment_cubit.dart';
import '../widget/booking_reusable_widgets.dart';
import 'booking_successful_screen.dart';

class ConfirmAppointmentScreen extends StatelessWidget {
  const ConfirmAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentCubit, BookAppointmentState>(
      builder: (context, state) {
        final dateStr = 'Wednesday, Oct ${state.selectedDateIndex}, 2023';
        final typeStr = state.isVideoCall ? 'Online Consultation' : 'In-Person Visit';
        
        return Scaffold(
          backgroundColor: bgGrey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black87),
              onPressed: () => Navigator.pop(context),
            ),
            title: const CustomText(
              text: 'Confirm Appointment',
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BookingDoctorCard(doctor: state.doctor),
                const SizedBox(height: 24),
                
                // Details Card
                Container(
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
                  child: Column(
                    children: [
                      _buildDetailRow(Icons.calendar_today_outlined, 'DATE', dateStr),
                      const Divider(height: 32),
                      _buildDetailRow(Icons.access_time_outlined, 'TIME', state.selectedTime),
                      const Divider(height: 32),
                      _buildDetailRow(Icons.videocam_outlined, 'LOCATION', typeStr, isLast: true),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                const SectionTitle(title: 'Reason for Visit'),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Briefly describe your symptoms (e.g., chest pain, recurring headaches)...',
                      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                      contentPadding: const EdgeInsets.all(16),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                const SectionTitle(title: 'Payment Method'),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.credit_card, color: primaryBlue),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            text: 'Visa ending in 4242',
                            fontWeight: FontWeight.bold, 
                            fontSize: 15,
                          ),
                          const SizedBox(height: 4),
                          CustomText(
                            text: 'Expires 12/25',
                            color: Colors.grey[600] ?? Colors.grey, 
                            fontSize: 13,
                          ),
                        ],
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: const CustomText(
                          text: 'Change', 
                          color: primaryBlue, 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(20),
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
                  child: Column(
                    children: [
                      _buildPricingRow('Consultation Fee', '\$45.00'),
                      const SizedBox(height: 12),
                      _buildPricingRow('Service Fee', '\$2.00'),
                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 12),
                      _buildPricingRow('Total', '\$47.00', isTotal: true),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                CustomButton(
                  text: 'Confirm Booking',
                  backgroundColor: primaryBlue,
                  textColor: Colors.white,
                  height: 56,
                  borderRadius: 16,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingSuccessfulScreen(
                          doctor: state.doctor,
                          dateStr: 'Wed, Oct ${state.selectedDateIndex}, 2023',
                          timeStr: state.selectedTime,
                          locationStr: state.isVideoCall 
                             ? 'Online Consultation' 
                             : 'Heartland Medical Center\nRoom 304, 3rd Floor',
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value, {bool isLast = false}) {
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: title,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey[500] ?? Colors.grey,
            ),
            const SizedBox(height: 4),
            CustomText(
              text: value,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPricingRow(String title, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: title,
          fontSize: isTotal ? 16 : 14,
          fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
          color: isTotal ? Colors.black87 : Colors.grey[600] ?? Colors.grey,
        ),
        CustomText(
          text: amount,
          fontSize: isTotal ? 18 : 14,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ],
    );
  }
}
