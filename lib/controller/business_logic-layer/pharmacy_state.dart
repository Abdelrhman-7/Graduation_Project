import 'package:graduation_project/models/model/pharmacy_model.dart';
import 'package:graduation_project/models/model/prescription_model.dart';

abstract class PharmacyState {}

class PharmacyInitial extends PharmacyState {}

class PharmacyLoading extends PharmacyState {}

class PharmacyLoaded extends PharmacyState {
  final PrescriptionModel prescription;
  final List<PharmacyModel> pharmacies;
  final PharmacyModel selectedPharmacy;

  PharmacyLoaded({
    required this.prescription,
    required this.pharmacies,
    required this.selectedPharmacy,
  });

  PharmacyLoaded copyWith({
    PrescriptionModel? prescription,
    List<PharmacyModel>? pharmacies,
    PharmacyModel? selectedPharmacy,
  }) {
    return PharmacyLoaded(
      prescription: prescription ?? this.prescription,
      pharmacies: pharmacies ?? this.pharmacies,
      selectedPharmacy: selectedPharmacy ?? this.selectedPharmacy,
    );
  }
}

class PharmacyError extends PharmacyState {
  final String message;
  PharmacyError(this.message);
}
