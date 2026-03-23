import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/model/doctor_model.dart';

part 'find_doctor_state.dart';

class FindDoctorCubit extends Cubit<FindDoctorState> {
  FindDoctorCubit() : super(FindDoctorInitial());

  static const List<DoctorModel> _allDoctors = [
    DoctorModel(
      id: '1',
      name: 'Ahmed Hassan',
      specialty: 'Cardiologist',
      imageUrl: '',
      rating: 4.8,
      reviewCount: 120,
      availableDay: 'Mon',
      hospital: 'Cairo Medical Center',
    ),
    DoctorModel(
      id: '2',
      name: 'Sara Khaled',
      specialty: 'Dermatologist',
      imageUrl: '',
      rating: 4.6,
      reviewCount: 98,
      availableDay: 'Tue',
      hospital: 'Nile Clinic',
    ),
    DoctorModel(
      id: '3',
      name: 'Mohamed Ali',
      specialty: 'Neurologist',
      imageUrl: '',
      rating: 4.9,
      reviewCount: 214,
      availableDay: 'Wed',
      hospital: 'El-Salam Hospital',
    ),
    DoctorModel(
      id: '4',
      name: 'Nour Ibrahim',
      specialty: 'Pediatrician',
      imageUrl: '',
      rating: 4.7,
      reviewCount: 155,
      availableDay: 'Thu',
      hospital: 'Kids Care Center',
    ),
    DoctorModel(
      id: '5',
      name: 'Laila Mahmoud',
      specialty: 'Orthopedist',
      imageUrl: '',
      rating: 4.5,
      reviewCount: 87,
      availableDay: 'Fri',
      hospital: 'Bones & Joints Clinic',
    ),
    DoctorModel(
      id: '6',
      name: 'Youssef Nader',
      specialty: 'Cardiologist',
      imageUrl: '',
      rating: 4.3,
      reviewCount: 60,
      availableDay: 'Sat',
      hospital: 'Heart Health Center',
    ),
    DoctorModel(
      id: '7',
      name: 'Rana Samir',
      specialty: 'Dermatologist',
      imageUrl: '',
      rating: 4.9,
      reviewCount: 305,
      availableDay: 'Sun',
      hospital: 'Skin & Beauty Clinic',
    ),
    DoctorModel(
      id: '8',
      name: 'Karim Fathy',
      specialty: 'General',
      imageUrl: '',
      rating: 4.2,
      reviewCount: 45,
      availableDay: 'Mon',
      hospital: 'Family Health Hub',
    ),
  ];

  String _selectedSpecialty = 'All';
  String _searchQuery = '';

  void loadDoctors() {
    emit(FindDoctorLoading());
    _emitFiltered();
  }

  void filterBySpecialty(String specialty) {
    _selectedSpecialty = specialty;
    _emitFiltered();
  }

  void search(String query) {
    _searchQuery = query;
    _emitFiltered();
  }

  void _emitFiltered() {
    List<DoctorModel> result = List.from(_allDoctors);

    if (_selectedSpecialty != 'All') {
      result = result.where((d) => d.specialty == _selectedSpecialty).toList();
    }

    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      result = result
          .where(
            (d) =>
                d.name.toLowerCase().contains(q) ||
                d.specialty.toLowerCase().contains(q),
          )
          .toList();
    }

    // Sort by rating (top rated first)
    result.sort((a, b) => b.rating.compareTo(a.rating));

    emit(
      FindDoctorLoaded(
        doctors: result,
        selectedSpecialty: _selectedSpecialty,
        searchQuery: _searchQuery,
      ),
    );
  }
}
