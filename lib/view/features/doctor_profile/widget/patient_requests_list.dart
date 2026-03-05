import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shered_widgites/custom_text/custom_text.dart';
import '../../../../shered_widgites/resources/colors_manager.dart';
import '../manager/patient_requests_cubit.dart';
import '../screen/patient_requests_screen.dart';
import 'patient_request_card.dart';

class PatientRequestsList extends StatelessWidget {
  const PatientRequestsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientRequestsCubit()..fetchRequests(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                text: 'Patient Requests',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorsManager.black,
              ),
              Builder(
                builder: (context) {
                  return TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<PatientRequestsCubit>(),
                            child: const PatientRequestsScreen(),
                          ),
                        ),
                      );
                    },
                    child: const CustomText(
                      text: 'See All',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ColorsManager.primaryBlue,
                    ),
                  );
                }
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 185,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.trackpad,
                },
              ),
              child: BlocBuilder<PatientRequestsCubit, PatientRequestsState>(
                builder: (context, state) {
                  if (state is PatientRequestsLoaded) {
                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.requests.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 300,
                          child: PatientRequestCard(request: state.requests[index]),
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
