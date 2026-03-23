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
        icon: Icons.assignment_outlined,
      ),
      PatientRequestModel(
        title: 'Drug Reaction Report',
        description: 'Minor skin rash',
        icon: Icons.report_problem_outlined,
      ),
      PatientRequestModel(
        title: 'Insurance Clearance',
        description: 'Prior authorization',
        icon: Icons.assignment_turned_in_outlined,
      ),
      PatientRequestModel(
        title: 'Vitals Log Review',
        description: 'High BP readings',
        icon: Icons.monitor_heart_outlined,
      ),
      PatientRequestModel(
        title: 'Refill Request',
        description: 'Metformin - 500mg',
        icon: Icons.medication_outlined,
      ),
      PatientRequestModel(
        title: 'New Patient Intake',
        description: 'Transfer from General',
        icon: Icons.person_search_outlined,
      ),
    ];

    emit(PatientRequestsLoaded(mockData));
  }

  void approveRequest(PatientRequestModel request) {
    if (state is PatientRequestsLoaded) {
      final updatedList = List<PatientRequestModel>.from((state as PatientRequestsLoaded).requests);
      updatedList.remove(request);
      emit(PatientRequestsLoaded(updatedList));
    }
  }

  void denyRequest(PatientRequestModel request) {
    if (state is PatientRequestsLoaded) {
      final updatedList = List<PatientRequestModel>.from((state as PatientRequestsLoaded).requests);
      updatedList.remove(request);
      emit(PatientRequestsLoaded(updatedList));
    }
  }
}
