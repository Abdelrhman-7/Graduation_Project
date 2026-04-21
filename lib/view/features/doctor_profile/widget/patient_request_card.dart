import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shered_widgites/custom_bouttm/custom_button.dart';
import '../../../../../shered_widgites/custom_text/custom_text.dart';
import '../../../../../shered_widgites/resources/colors_manager.dart';
import '../manager/patient_requests_cubit.dart';
import '../model/patient_request_model.dart';

class PatientRequestCard extends StatelessWidget {
  final PatientRequestModel request;

  const PatientRequestCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ColorsManager.lightOrange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(request.icon, color: ColorsManager.iconOrange),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: request.title,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.black,
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      text: request.description,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.gray,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Deny',
                  onPressed: () {
                    context.read<PatientRequestsCubit>().denyRequest(request);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Request for ${request.title} denied'),
                      ),
                    );
                  },
                  backgroundColor: ColorsManager.white,
                  textColor: ColorsManager.primaryBlue,
                  // ignore: deprecated_member_use
                  side: BorderSide(
                    // ignore: deprecated_member_use
                    color: ColorsManager.primaryBlue.withOpacity(0.5),
                  ),
                  height: 48,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButton(
                  text: 'Approve',
                  onPressed: () {
                    context.read<PatientRequestsCubit>().approveRequest(
                      request,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Request for ${request.title} approved'),
                      ),
                    );
                  },
                  backgroundColor: ColorsManager.primaryBlue,
                  textColor: ColorsManager.white,
                  height: 48,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
