import 'package:flutter/material.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

class DetailedResultsCard extends StatelessWidget {
  const DetailedResultsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Column(
        children: [
          DetailRow(
            name: 'Glucose (Fasting)',
            value: '95 mg/dL',
            reference: '70–100 mg/dL',
            isNormal: true,
            showDivider: true,
          ),
          DetailRow(
            name: 'Cholesterol',
            value: '210 mg/dL',
            reference: '< 200 mg/dL',
            isNormal: false,
            showDivider: false,
          ),
        ],
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String name;
  final String value;
  final String reference;
  final bool isNormal;
  final bool showDivider;

  const DetailRow({
    super.key,
    required this.name,
    required this.value,
    required this.reference,
    required this.isNormal,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              // Status icon
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isNormal
                      ? ColorsManager.lightGreen
                      : const Color(0xFFFFEBEE),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isNormal
                      ? Icons.check_rounded
                      : Icons.warning_amber_rounded,
                  color: isNormal
                      ? ColorsManager.iconGreen
                      : const Color(0xFFE53935),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              // Name + reference
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ColorsManager.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Ref: $reference',
                      style: const TextStyle(
                        fontSize: 11,
                        color: ColorsManager.lightGray,
                      ),
                    ),
                  ],
                ),
              ),
              // Value
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isNormal
                      ? ColorsManager.iconGreen
                      : const Color(0xFFE53935),
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          const Divider(height: 1, thickness: 1, indent: 16, endIndent: 16),
      ],
    );
  }
}
