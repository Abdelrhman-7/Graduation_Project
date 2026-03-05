import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../model/patient_request_model.dart';

abstract class PatientRequestsState {}

class PatientRequestsInitial extends PatientRequestsState {}

class PatientRequestsLoaded extends PatientRequestsState {
  final List<PatientRequestModel> requests;

  PatientRequestsLoaded(this.requests);
}

class PatientRequestsCubit extends Cubit<PatientRequestsState> {
  PatientRequestsCubit() : super(PatientRequestsInitial());

  void fetchRequests() {
    // محاكاة جلب البيانات
    final mockData = [
      PatientRequestModel(
        title: 'Refill Request',
        description: 'Lisinopril - 10mg',
        icon: Icons.medication_outlined,
      ),
      PatientRequestModel(
        title: 'Appointment Request',
        description: 'Follow-up Check',
        icon: Icons.calendar_month_outlined,
      ),
      PatientRequestModel(
        title: 'Lab Result Request',
        description: 'Blood Test Update',
        icon: Icons.science_outlined,
      ),
      PatientRequestModel(
        title: 'Referral Request',
        description: 'To Specialist',
        icon: Icons.person_add_alt_1_outlined,
      ),
      PatientRequestModel(
        title: 'Medical Certificate',
        description: 'Sick Leave 3 days',
        icon: Icons.edit_document,
      ),
      PatientRequestModel(
        title: 'Refill Request',
        description: 'Metformin - 500mg',
        icon: Icons.medication_outlined,
      ),
    ];

    emit(PatientRequestsLoaded(mockData));
  }
}
