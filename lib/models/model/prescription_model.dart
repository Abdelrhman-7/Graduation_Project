import 'package:graduation_project/models/model/medicine_model.dart';

class PrescriptionModel {
  final String id;
  final String status;
  final MedicineModel medicine;
  final List<String> instructions;
  final String doctorName;
  final String doctorSpecialty;
  final String doctorImageUrl;

  const PrescriptionModel({
    required this.id,
    required this.status,
    required this.medicine,
    required this.instructions,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorImageUrl,
  });
}
