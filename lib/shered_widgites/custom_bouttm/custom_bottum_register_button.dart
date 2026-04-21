import 'package:flutter/material.dart';
import 'package:graduation_project/controller/business_logic-layer/login_cubit.dart';
import 'package:graduation_project/controller/business_logic-layer/register_cubit.dart';
import 'package:graduation_project/controller/business_logic-layer/forget_password_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/model/login_model.dart';
import 'package:graduation_project/models/model/register_model.dart';

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
            context.read<RegisterCubit>().register(
              RegisterRequest(
                email: emailController?.text ?? "",
                password: passwordController?.text ?? "",
                fullName: userNameController?.text ?? "",
              ),

              /*   email: emailController?.text ?? "",
              password: passwordController?.text ?? "",
              confirmPassword: confirmPassword?.text ?? "",
              userName: userNameController?.text ?? "",
              mobileNumber: mobileNumberController?.text ?? "",
              countryMobileCode: countryMobileCode?.text ?? "",
              profilePicture: profilePicture?.text ?? "",*/
            );
          } else if (text == "login") {
            context.read<LoginCubit>().login(
              /* emailController?.text ?? "",
              passwordController?.text ?? "",*/
              LoginRequest(
                email: emailController?.text ?? "",
                password: passwordController?.text ?? "",
              ),
            );
          } else if (text == "forget password") {
            context.read<ForgetPasswordCubit>().forgetPassword(
              email: emailController?.text ?? "",
            );
          }
        }
      },
      child: Text(text ?? ''),
    );
  }
}
