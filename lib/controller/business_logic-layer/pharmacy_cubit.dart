import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/controller/business_logic-layer/pharmacy_state.dart';
import 'package:graduation_project/models/model/medicine_model.dart';
import 'package:graduation_project/models/model/pharmacy_model.dart';
import 'package:graduation_project/models/model/prescription_model.dart';

class PharmacyCubit extends Cubit<PharmacyState> {
  PharmacyCubit() : super(PharmacyInitial());

  void loadPrescription() {
    emit(PharmacyLoading());

    // Mock Data
    final prescription = PrescriptionModel(
      id: "4920",
      status: "Active",
      medicine: const MedicineModel(
        name: "Amoxicillin",
        dosage: "500mg",
        genericName: "Generic for Amoxi",
        count: "30 capsules",
        imageUrl: "assets/images/medicine.png",
      ),
      instructions: [
        "Take 1 capsule every 8 hours",
        "Duration: 7 days",
        "Take with food",
        "Complete the full course even if feeling better"
      ],
      doctorName: "Dr. Sarah Johnson",
      doctorSpecialty: "General Physician",
      doctorImageUrl: "",
    );

    final pharmacies = [
      const PharmacyModel(
        name: "CVS Pharmacy",
        address: "123 Medical Dr, Ste 100",
        icon: Icons.local_pharmacy,
        isInStock: true,
      ),
      const PharmacyModel(
        name: "Walgreens",
        address: "456 Health St",
        icon: Icons.local_pharmacy_outlined,
        isInStock: true,
      ),
      const PharmacyModel(
        name: "Rite Aid",
        address: "789 Wellness Rd",
        icon: Icons.medical_services_outlined,
        isInStock: false,
      ),
    ];

    emit(PharmacyLoaded(
      prescription: prescription,
      pharmacies: pharmacies,
      selectedPharmacy: pharmacies[0],
    ));
  }

  void selectPharmacy(PharmacyModel pharmacy) {
    if (state is PharmacyLoaded) {
      emit((state as PharmacyLoaded).copyWith(selectedPharmacy: pharmacy));
    }
  }
}
