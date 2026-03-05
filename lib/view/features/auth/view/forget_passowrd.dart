import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/controller/business_logic-layer/test_api_cubit.dart';
import 'package:graduation_project/shered_widgites/custom_bouttm/custom_button.dart';
import 'package:graduation_project/shered_widgites/custom_text_filed/custom_text_field.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';
import 'package:graduation_project/shered_widgites/resources/image_assets.dart';

class ForgetPassowrd extends StatefulWidget {
  const ForgetPassowrd({super.key});

  @override
  State<ForgetPassowrd> createState() => _ForgetPassowrdState();
}

class _ForgetPassowrdState extends State<ForgetPassowrd> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _sendResetLink() {
    if (_formKey.currentState!.validate()) {
      context.read<TestApiCubit>().forgetPassword(email: emailController.text);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      appBar: AppBar(
        backgroundColor: ColorsManager.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: ColorsManager.black),
      ),
      body: BlocConsumer<TestApiCubit, TestApiState>(
        listener: (context, state) {
          if (state is TestApiSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is TestApiError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImageAssets.forgetPassword, height: 150),
                        const SizedBox(height: 20),
                        const Text(
                          "Forget Password",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Enter the email address associated with your\naccount and we'll send you a secure link to\nreset your password.",
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorsManager.lightGray,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        CustomTextField(
                          controller: emailController,
                          labelText: "Email",
                          hintText: "Enter your email",
                          errorText: "Please enter your email",
                          prefixIcon: const Icon(Icons.email_outlined),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your email";
                            }
                            if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(value)) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        state is TestApiLoading
                            ? const CircularProgressIndicator(
                                color: ColorsManager.purble,
                              )
                            : CustomButton(
                                text: "Send Reset Link",
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                                onPressed: _sendResetLink,
                              ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Return to login
                          },
                          child: const Text(
                            "Back to Login",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.purble,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
