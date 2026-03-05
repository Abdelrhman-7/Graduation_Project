import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/model/doctor_model.dart';
import 'package:graduation_project/shered_widgites/custom_bouttm/custom_button.dart';
import 'package:graduation_project/shered_widgites/custom_text/custom_text.dart';
import '../manager/book_appointment_cubit.dart';
import '../widget/booking_reusable_widgets.dart';
import 'confirm_appointment.dart';

class BookAppointmentScreen extends StatelessWidget {
  final DoctorModel doctor;
  
  const BookAppointmentScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookAppointmentCubit(doctor),
      child: const _BookAppointmentView(),
    );
  }
}

class _BookAppointmentView extends StatelessWidget {
  const _BookAppointmentView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentCubit, BookAppointmentState>(
      builder: (context, state) {
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
              text: 'Select Time',
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BookingDoctorCard(doctor: state.doctor),
                  const SizedBox(height: 24),
                  const SectionTitle(title: 'Appointment Type'),
                  const SizedBox(height: 16),
                  AppointmentTypeToggle(
                    isVideoCall: state.isVideoCall,
                    onChanged: (val) => context.read<BookAppointmentCubit>().updateType(val),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SectionTitle(title: 'October 2023'),
                      Icon(Icons.calendar_today_outlined, color: Colors.grey[600], size: 20),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildDateSelector(context, state.selectedDateIndex),
                  const SizedBox(height: 24),
                  _buildTimeSlots(context, state, 'MORNING', ['09:00 AM', '09:30 AM', '10:00 AM', '10:30 AM']),
                  const SizedBox(height: 20),
                  _buildTimeSlots(context, state, 'AFTERNOON', ['12:00 PM', '12:30 PM', '01:00 PM', '01:30 PM', '02:00 PM']),
                  const SizedBox(height: 20),
                  _buildTimeSlots(context, state, 'EVENING', ['05:00 PM', '05:30 PM', '06:00 PM']),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          bottomSheet: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Oct ${state.selectedDateIndex}, ${state.selectedTime} • ${state.isVideoCall ? 'Video Call' : 'In-Person'}',
                            fontSize: 14,
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                          ),
                          const SizedBox(height: 4),
                          const CustomText(
                            text: '\$45.00',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Confirm Appointment',
                    backgroundColor: primaryBlue,
                    textColor: Colors.white,
                    height: 56,
                    borderRadius: 16,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<BookAppointmentCubit>(),
                            child: const ConfirmAppointmentScreen(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDateSelector(BuildContext context, int selectedDateIndex) {
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return SizedBox(
      height: 85,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
          },
        ),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: 31,
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final date = index + 1;
            final isSelected = date == selectedDateIndex;
            final dayName = days[date % 7];
            
            return GestureDetector(
              onTap: () => context.read<BookAppointmentCubit>().updateDate(date),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 65,
                decoration: BoxDecoration(
                  color: isSelected ? primaryBlue : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected ? primaryBlue : Colors.grey[300]!,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: dayName,
                      color: isSelected ? Colors.white70 : Colors.grey[600] ?? Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      text: date.toString(),
                      color: isSelected ? Colors.white : Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTimeSlots(BuildContext context, BookAppointmentState state, String title, List<String> slots) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey[500] ?? Colors.grey,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: slots.map((time) {
            return TimeSlotButton(
              time: time,
              isSelected: state.selectedTime == time,
              onTap: () => context.read<BookAppointmentCubit>().updateTime(time),
            );
          }).toList(),
        ),
      ],
    );
  }
}
