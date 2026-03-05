import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/controller/business_logic-layer/test_api_cubit.dart';
import 'package:graduation_project/models/model/shered_pref_controller/shered_pref_controler.dart';
import 'package:graduation_project/shered_widgites/custom_bouttm/custom_button.dart';
import 'package:graduation_project/shered_widgites/custom_text_filed/custom_text_field.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';
import 'package:graduation_project/shered_widgites/routes_manager.dart';
import 'package:graduation_project/view/features/auth/widget/auth_header_logo.dart';
import 'package:graduation_project/view/features/auth/widget/customTextButton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();
  final SharedPrefController prefController = SharedPrefController();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: "naderawny@gmail.com");
    passwordController = TextEditingController(text: "nader12345");
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      appBar: AppBar(title: const Text("Login Screen"), centerTitle: true),
      body: BlocConsumer<TestApiCubit, TestApiState>(
        listener: (context, state) {
          if (state is TestApiSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            prefController.saveLogin(emailController.text);
            Navigator.pushNamed(context, RoutManager.home);
          } else if (state is TestApiError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AuthHeaderLogo(title: "Welcome Dr / Patient"),
                      const SizedBox(height: 40),
                      CustomTextField(
                        controller: emailController,
                        errorText: 'Please enter your email',
                        hintText: "Enter your email",
                        labelText: "Email",
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: passwordController,
                        errorText: 'Please enter your password',
                        hintText: "Enter your password",
                        labelText: "Password",
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: customTextButton(
                          text2: "Forget Password?",
                          rout: RoutManager.forgetPassword,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: "Login",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<TestApiCubit>().login(
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      customTextButton(
                        text: "Don't have an account?",
                        text2: "Register",
                        //: RoutManager.registerscreen,
                      ),
                    ],
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
