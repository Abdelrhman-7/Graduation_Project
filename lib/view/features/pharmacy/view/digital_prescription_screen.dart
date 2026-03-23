import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/controller/business_logic-layer/pharmacy_cubit.dart';
import 'package:graduation_project/controller/business_logic-layer/pharmacy_state.dart';
import 'package:graduation_project/shered_widgites/custom_bouttm/custom_button.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';
import 'package:graduation_project/view/features/find_doctor/widget/doctor_details_widgets.dart';
import 'package:graduation_project/view/features/pharmacy/widget/instructions_list.dart';
import 'package:graduation_project/view/features/pharmacy/widget/medicine_info_card.dart';
import 'package:graduation_project/view/features/pharmacy/widget/pharmacy_selection_card.dart';
import 'package:graduation_project/view/features/pharmacy/widget/prescription_header.dart';

class DigitalPrescriptionScreen extends StatelessWidget {
  const DigitalPrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ColorsManager.black,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Digital Prescription',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorsManager.black,
          ),
        ),
      ),
      body: BlocBuilder<PharmacyCubit, PharmacyState>(
        builder: (context, state) {
          if (state is PharmacyLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PharmacyError) {
            return Center(child: Text(state.message));
          }
          if (state is PharmacyLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrescriptionHeader(state: state),
                  const SizedBox(height: 20),
                  MedicineInfoCard(state: state),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Instructions'),
                  const SizedBox(height: 12),
                  InstructionsList(state: state),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Prescribed by'),
                  const SizedBox(height: 12),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Select Pharmacy'),
                  const SizedBox(height: 12),
                  ...state.pharmacies.map(
                    (p) => PharmacySelectionCard(
                      pharmacy: p,
                      isSelected: state.selectedPharmacy.name == p.name,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    text: 'Send to ${state.selectedPharmacy.name}',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Prescription sent to ${state.selectedPharmacy.name}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                    backgroundColor: ColorsManager.purble,
                    borderRadius: 16,
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: ColorsManager.black,
      ),
    );
  }
}
