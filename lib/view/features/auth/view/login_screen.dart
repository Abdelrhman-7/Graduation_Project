import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/controller/business_logic-layer/login_cubit.dart';
import 'package:graduation_project/models/model/login_model.dart';
import 'package:graduation_project/models/model/shered_pref_controller/shered_pref_controler.dart';
import 'package:graduation_project/shered_widgites/custom_bouttm/custom_button.dart';
import 'package:graduation_project/shered_widgites/custom_text_filed/custom_text_field.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';
import 'package:graduation_project/shered_widgites/routes_manager.dart';
import 'package:graduation_project/view/features/auth/widget/auth_header_logo.dart';
import 'package:graduation_project/view/features/auth/widget/customTextButton.dart';
import 'package:graduation_project/shered_widgites/string/app_string.dart';

class LoginScreen extends StatefulWidget {
  final String? role;
  const LoginScreen({super.key, this.role});

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
    emailController = TextEditingController(
      text: "wwwabdelrhmanmahmoud22@gmail.com",
    );
    passwordController = TextEditingController(text: "123456789@#\$Abdo");
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
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.response.message ?? 'Login Successful'),
              ),
            );
            prefController.saveLogin(emailController.text);
            if (widget.role == AppString.doctor) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RoutManager.home,
                (route) => false,
              );
            } else if (widget.role == AppString.patient) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RoutManager.patientHome,
                (route) => false,
              );
            } else {
              Navigator.pushNamed(context, RoutManager.patientHome);
            }
          } else if (state is LoginError) {
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
                      AuthHeaderLogo(
                        title: widget.role == null
                            ? "Welcome Dr / Patient"
                            : "Welcome ${widget.role}",
                      ),
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
                      state is LoginLoading
                          ? const CircularProgressIndicator()
                          : CustomButton(
                              text: "Login",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<LoginCubit>().login(
                                    LoginRequest(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ),
                                  );
                                }
                              },
                            ),
                      const SizedBox(height: 10),
                      customTextButton(
                        text: "Don't have an account?",
                        text2: "Register",
                        rout: RoutManager.chooseAccount,
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
