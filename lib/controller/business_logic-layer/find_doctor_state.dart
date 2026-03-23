part of 'find_doctor_cubit.dart';

abstract class FindDoctorState {}

class FindDoctorInitial extends FindDoctorState {}

class FindDoctorLoading extends FindDoctorState {}

class FindDoctorLoaded extends FindDoctorState {
  final List<DoctorModel> doctors;
  final String selectedSpecialty;
  final String searchQuery;

  FindDoctorLoaded({
    required this.doctors,
    required this.selectedSpecialty,
    required this.searchQuery,
  });
}

class FindDoctorError extends FindDoctorState {
  final String message;
  FindDoctorError(this.message);
}
