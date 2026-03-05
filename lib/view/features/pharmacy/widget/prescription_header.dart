import 'package:flutter/material.dart';
import 'package:graduation_project/controller/business_logic-layer/pharmacy_state.dart';

class PrescriptionHeader extends StatelessWidget {
  final PharmacyLoaded state;

  const PrescriptionHeader({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Prescription #${state.prescription.id}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Active',
            style: TextStyle(
              color: Colors.green,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
