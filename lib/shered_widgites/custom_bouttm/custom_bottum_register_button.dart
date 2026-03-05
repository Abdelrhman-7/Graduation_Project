import 'package:flutter/material.dart';
import 'package:graduation_project/controller/business_logic-layer/test_api_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomRegisterButton extends StatelessWidget {
  const CustomRegisterButton({
    super.key,
    this.emailController,
    this.passwordController,
    this.formKey,
    this.confirmPassword,
    this.userNameController,
    this.mobileNumberController,
    this.countryMobileCode,
    this.profilePicture,
    this.text,
  });

  final GlobalKey<FormState>? formKey;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final TextEditingController? confirmPassword;
  final TextEditingController? userNameController;
  final TextEditingController? mobileNumberController;
  final TextEditingController? countryMobileCode;
  final TextEditingController? profilePicture;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (formKey?.currentState?.validate() == true) {
          if (text == "register") {
            if (passwordController?.text != confirmPassword?.text) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Passwords do not match")),
              );
              return;
            }
            context.read<TestApiCubit>().register(
              email: emailController?.text ?? "",
              password: passwordController?.text ?? "",
              confirmPassword: confirmPassword?.text ?? "",
              userName: userNameController?.text ?? "",
              mobileNumber: mobileNumberController?.text ?? "",
              countryMobileCode: countryMobileCode?.text ?? "",
              profilePicture: profilePicture?.text ?? "",
            );
          } else if (text == "login") {
            context.read<TestApiCubit>().login(
              emailController?.text ?? "",
              passwordController?.text ?? "",
            );
          } else if (text == "forget password") {
            context.read<TestApiCubit>().forgetPassword(
              email: emailController?.text ?? "",
            );
          }
        }
      },
      child: Text(text ?? ''),
    );
  }
}
