import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/controller/business_logic-layer/find_doctor_cubit.dart';
import 'package:graduation_project/view/features/find_doctor/widget/doctor_card.dart';
import 'package:graduation_project/view/features/find_doctor/widget/specialty_filter_chip.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';
import 'package:graduation_project/view/features/book_Appointment/view/book_Appointment.dart';
import 'package:graduation_project/view/features/find_doctor/view/doctor_details_screen.dart';

// Specialty data: label + icon
const List<Map<String, dynamic>> _specialties = [
  {'label': 'All', 'icon': Icons.grid_view_rounded},
  {'label': 'Cardiologist', 'icon': Icons.favorite_rounded},
  {'label': 'Dermatologist', 'icon': Icons.spa_rounded},
  {'label': 'Neurologist', 'icon': Icons.psychology_rounded},
  {'label': 'Pediatrician', 'icon': Icons.child_care_rounded},
  {'label': 'Orthopedist', 'icon': Icons.accessibility_new_rounded},
  {'label': 'General', 'icon': Icons.local_hospital_rounded},
];

class FindDoctorScreen extends StatefulWidget {
  const FindDoctorScreen({super.key});

  @override
  State<FindDoctorScreen> createState() => _FindDoctorScreenState();
}

class _FindDoctorScreenState extends State<FindDoctorScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          _buildSearchAndFilter(context),
          _buildSpecialtyList(context),
          _buildTopRatedLabel(),
          _buildDoctorList(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
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
        'Find Doctor',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: ColorsManager.black,
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: BlocBuilder<FindDoctorCubit, FindDoctorState>(
              builder: (context, state) {
                return Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F7FF),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFFE0E0E0),
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) =>
                        context.read<FindDoctorCubit>().search(value),
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorsManager.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search doctor, specialty...',
                      hintStyle: const TextStyle(
                        color: ColorsManager.lightGray,
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: ColorsManager.purble,
                        size: 22,
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.close_rounded,
                                color: ColorsManager.lightGray,
                                size: 20,
                              ),
                              onPressed: () {
                                _searchController.clear();
                                context.read<FindDoctorCubit>().search('');
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Builder(
            builder: (ctx) => GestureDetector(
              onTap: () => _showFilterSheet(ctx),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: ColorsManager.purble,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.tune_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialtyList(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 16, bottom: 14, top: 4),
      child: BlocBuilder<FindDoctorCubit, FindDoctorState>(
        builder: (context, state) {
          final selected = state is FindDoctorLoaded
              ? state.selectedSpecialty
              : 'All';
          return SizedBox(
            height: 46,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _specialties.length,
              itemBuilder: (_, i) {
                final sp = _specialties[i];
                final label = sp['label'] as String;
                return SpecialtyFilterChip(
                  label: label,
                  icon: sp['icon'] as IconData,
                  isSelected: selected == label,
                  onTap: () =>
                      context.read<FindDoctorCubit>().filterBySpecialty(label),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopRatedLabel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: ColorsManager.purble,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Top Rated',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: ColorsManager.black,
            ),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.star_rounded, color: ColorsManager.yellow, size: 18),
        ],
      ),
    );
  }

  Widget _buildDoctorList() {
    return Expanded(
      child: BlocBuilder<FindDoctorCubit, FindDoctorState>(
        builder: (context, state) {
          if (state is FindDoctorLoading) {
            return const Center(
              child: CircularProgressIndicator(color: ColorsManager.purble),
            );
          }

          if (state is FindDoctorError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is FindDoctorLoaded) {
            if (state.doctors.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off_rounded,
                      // ignore: deprecated_member_use
                      size: 70,
                      color: ColorsManager.lightGray.withOpacity(0.6),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'No doctors found',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorsManager.lightGray,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: state.doctors.length,
              itemBuilder: (_, i) {
                final doc = state.doctors[i];
                return DoctorCard(
                  doctor: doc,
                  onViewProfile: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorDetailsScreen(doctor: doc),
                      ),
                    );
                  },
                  onBook: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookAppointmentScreen(doctor: doc),
                      ),
                    );
                  },
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => BlocProvider.value(
        value: BlocProvider.of<FindDoctorCubit>(context),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: ColorsManager.lightGray.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Filter by Specialty',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.black,
                ),
              ),
              const SizedBox(height: 14),
              BlocBuilder<FindDoctorCubit, FindDoctorState>(
                builder: (ctx2, state) {
                  final selected = state is FindDoctorLoaded
                      ? state.selectedSpecialty
                      : 'All';
                  return Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _specialties.map((sp) {
                      final label = sp['label'] as String;
                      return SpecialtyFilterChip(
                        label: label,
                        icon: sp['icon'] as IconData,
                        isSelected: selected == label,
                        onTap: () {
                          context.read<FindDoctorCubit>().filterBySpecialty(
                            label,
                          );
                          Navigator.of(ctx).pop();
                        },
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
