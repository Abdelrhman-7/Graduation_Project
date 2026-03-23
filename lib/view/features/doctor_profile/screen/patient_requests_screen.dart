import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shered_widgites/custom_text/custom_text.dart';
import '../../../../../shered_widgites/resources/colors_manager.dart';
import '../manager/patient_requests_cubit.dart';
import '../widget/patient_request_card.dart';

class PatientRequestsScreen extends StatelessWidget {
  const PatientRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: ColorsManager.black),
        title: const CustomText(
          text: 'All Patient Requests',
          color: ColorsManager.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: BlocBuilder<PatientRequestsCubit, PatientRequestsState>(
        builder: (context, state) {
          if (state is PatientRequestsLoaded) {
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              itemCount: state.requests.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return PatientRequestCard(request: state.requests[index]);
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
