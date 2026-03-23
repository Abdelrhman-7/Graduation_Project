import 'package:flutter/material.dart';
import 'package:graduation_project/shered_widgites/custom_bouttm/custom_button.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

class MedicationRefillScreen extends StatefulWidget {
  final Map<String, String> medication;

  const MedicationRefillScreen({super.key, required this.medication});

  @override
  State<MedicationRefillScreen> createState() =>
      _MedicationRefillScreenState();
}

class _MedicationRefillScreenState extends State<MedicationRefillScreen> {
  int _selectedPharmacy = 0;

  final List<Map<String, dynamic>> _pharmacies = [
    {
      'name': 'CVS Pharmacy',
      'distance': '0.5 mi',
      'address': '123 Main St, Downtown',
      'stock': 'In Stock',
      'stockColor': ColorsManager.iconGreen,
      // ignore: deprecated_member_use
      'stockBg': const Color(0xFFE8F5E9),
    },
    {
      'name': 'Walgreens',
      'distance': '1.2 mi',
      'address': '450 Highland Ave, North',
      'stock': 'Low Stock',
      'stockColor': ColorsManager.iconOrange,
      'stockBg': ColorsManager.lightOrange,
    },
    {
      'name': 'Rite Aid',
      'distance': '2.8 mi',
      'address': '880 Broadway, West',
      'stock': 'Out of Stock',
      'stockColor': ColorsManager.lightGray,
      'stockBg': const Color(0xFFF0F0F0),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final name = widget.medication['name'] ?? '';
    final dose = widget.medication['dose'] ?? '';
    final times = widget.medication['times'] ?? '';
    final selectedName = _pharmacies[_selectedPharmacy]['name'] as String;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      appBar: _buildAppBar(context, name),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Status Badge ──────────────────────────────────────
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: ColorsManager.iconGreen,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check,
                          color: Colors.white, size: 12),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'ACTIVE PRESCRIPTION',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.iconGreen,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ── Medication Card ───────────────────────────────────
            _buildMedicineCard(name, dose, times),
            const SizedBox(height: 24),

            // ── Instructions ──────────────────────────────────────
            _buildSectionTitle('Instructions'),
            const SizedBox(height: 12),
            _buildInstructionsGrid(dose, times),
            const SizedBox(height: 24),

            // ── Prescribed By ─────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionTitle('Prescribed By'),
                const Text(
                  'Issued Oct 24, 2025',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorsManager.lightGray,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildDoctorCard(),
            const SizedBox(height: 24),

            // ── Select Pharmacy ───────────────────────────────────
            _buildSectionTitle('Select Pharmacy'),
            const SizedBox(height: 12),
            ...List.generate(
              _pharmacies.length,
              (i) => _buildPharmacyCard(i),
            ),
            const SizedBox(height: 8),

            // ── Send Button ───────────────────────────────────────
            CustomButton(
              text: 'Send to $selectedName',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Prescription sent to $selectedName',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: ColorsManager.purble,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                );
              },
              backgroundColor: ColorsManager.purble,
              textColor: Colors.white,
              height: 56,
              borderRadius: 16,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              icon: const Icon(Icons.arrow_forward_rounded,
                  color: Colors.white, size: 20),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // ── AppBar ─────────────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar(BuildContext context, String name) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded,
            color: ColorsManager.black, size: 20),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: ColorsManager.black,
        ),
      ),
    );
  }

  // ── Medication Card ────────────────────────────────────────────
  Widget _buildMedicineCard(String name, String dose, String times) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.black,
                  ),
                ),
                const Text(
                  'Current Medication',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorsManager.lightGray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.medication_rounded,
                        size: 16, color: ColorsManager.purble),
                    const SizedBox(width: 4),
                    Text(
                      dose,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ColorsManager.purble,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  times,
                  style: const TextStyle(
                    fontSize: 13,
                    color: ColorsManager.lightGray,
                  ),
                ),
              ],
            ),
          ),
          // Right: icon container
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: ColorsManager.purble.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.medication_rounded,
              color: ColorsManager.purble,
              size: 46,
            ),
          ),
        ],
      ),
    );
  }

  // ── Instructions Grid ──────────────────────────────────────────
  Widget _buildInstructionsGrid(String dose, String times) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                _gridItem(Icons.access_time_rounded, 'Frequency', times),
                const VerticalDivider(
                    width: 1, thickness: 1, color: Color(0xFFF1F1F1)),
                _gridItem(Icons.calendar_today_rounded, 'Duration', '30 days'),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F1F1)),
          IntrinsicHeight(
            child: Row(
              children: [
                _gridItem(Icons.medication_rounded, 'Method', 'Oral'),
                const VerticalDivider(
                    width: 1, thickness: 1, color: Color(0xFFF1F1F1)),
                _gridItem(
                    Icons.info_outline_rounded, 'Note', 'Take with food'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _gridItem(IconData icon, String label, String value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: ColorsManager.purble),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: ColorsManager.lightGray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: ColorsManager.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Doctor Card ────────────────────────────────────────────────
  Widget _buildDoctorCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            // ignore: deprecated_member_use
            backgroundColor: ColorsManager.purble.withOpacity(0.12),
            child: const Icon(Icons.person_rounded,
                color: ColorsManager.purble, size: 26),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. Sarah Lin',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.black,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'General Practitioner',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorsManager.lightGray,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'License #MD88201',
                  style: TextStyle(
                    fontSize: 11,
                    color: ColorsManager.lightGray,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: ColorsManager.purble.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.chat_bubble_outline_rounded,
                color: ColorsManager.purble, size: 20),
          ),
        ],
      ),
    );
  }

  // ── Pharmacy Card ──────────────────────────────────────────────
  Widget _buildPharmacyCard(int index) {
    final p = _pharmacies[index];
    final isSelected = _selectedPharmacy == index;
    final stockColor = p['stockColor'] as Color;
    final stockBg = p['stockBg'] as Color;

    return GestureDetector(
      onTap: () => setState(() => _selectedPharmacy = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? ColorsManager.purble : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: ColorsManager.purble.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.local_pharmacy_outlined,
                  color: ColorsManager.purble, size: 24),
            ),
            const SizedBox(width: 12),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        p['name'] as String,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.black,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined,
                              size: 13, color: ColorsManager.lightGray),
                          const SizedBox(width: 2),
                          Text(
                            p['distance'] as String,
                            style: const TextStyle(
                              fontSize: 12,
                              color: ColorsManager.lightGray,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    p['address'] as String,
                    style: const TextStyle(
                      fontSize: 12,
                      color: ColorsManager.lightGray,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: stockBg,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          p['stock'] as String,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: stockColor,
                          ),
                        ),
                      ),
                      if (isSelected) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: ColorsManager.lightPurple,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'SELECTED',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.purble,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: const Icon(Icons.check_circle_rounded,
                    color: ColorsManager.purble, size: 24),
              ),
          ],
        ),
      ),
    );
  }

  // ── Section Title ──────────────────────────────────────────────
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
