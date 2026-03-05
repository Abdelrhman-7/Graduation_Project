import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/model/doctor_model.dart';

class BookAppointmentState {
  final DoctorModel doctor;
  final bool isVideoCall;
  final int selectedDateIndex;
  final String selectedTime;

  BookAppointmentState({
    required this.doctor,
    this.isVideoCall = true,
    this.selectedDateIndex = 12,
    this.selectedTime = '09:30 AM',
  });

  BookAppointmentState copyWith({
    DoctorModel? doctor,
    bool? isVideoCall,
    int? selectedDateIndex,
    String? selectedTime,
  }) {
    return BookAppointmentState(
      doctor: doctor ?? this.doctor,
      isVideoCall: isVideoCall ?? this.isVideoCall,
      selectedDateIndex: selectedDateIndex ?? this.selectedDateIndex,
      selectedTime: selectedTime ?? this.selectedTime,
    );
  }
}

class BookAppointmentCubit extends Cubit<BookAppointmentState> {
  BookAppointmentCubit(DoctorModel initialDoctor)
      : super(BookAppointmentState(doctor: initialDoctor));

  void updateType(bool isVideo) {
    emit(state.copyWith(isVideoCall: isVideo));
  }

  void updateDate(int dateIndex) {
    emit(state.copyWith(selectedDateIndex: dateIndex));
  }

  void updateTime(String time) {
    emit(state.copyWith(selectedTime: time));
  }
}
