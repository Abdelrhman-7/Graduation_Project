import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/controller/business_logic-layer/login_cubit.dart';
import 'package:graduation_project/controller/business_logic-layer/register_cubit.dart';
import 'package:graduation_project/controller/business_logic-layer/forget_password_cubit.dart';
import 'package:graduation_project/controller/business_logic-layer/find_doctor_cubit.dart';
import 'package:graduation_project/controller/business_logic-layer/pharmacy_cubit.dart';
import 'package:graduation_project/models/api_manager/api_manager.dart';
import 'package:graduation_project/models/model/shered_pref_controller/shered_pref_controler.dart';
import 'package:graduation_project/models/repository/repository.dart';
import 'package:graduation_project/shered_widgites/routes_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefController = SharedPrefController();
  bool isLoggedIn = await prefController.isLoggedIn();
  runApp(
    GraduationProjectApp(
      initialRoute: isLoggedIn ? RoutManager.login : RoutManager.chooseAccount,
    ),
  );
}

class GraduationProjectApp extends StatelessWidget {
  final String initialRoute;
  const GraduationProjectApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        final apiManager = ApiManager();
        final repository = Repository(apiManager);
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => LoginCubit(apiManager)),
            BlocProvider(create: (_) => RegisterCubit(apiManager)),
            BlocProvider(create: (_) => ForgetPasswordCubit(apiManager)),
            BlocProvider(create: (_) => FindDoctorCubit()..loadDoctors()),
            BlocProvider(create: (_) => PharmacyCubit()..loadPrescription()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Graduation Project',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            onGenerateRoute: RoutManager.generateRoute,
            initialRoute: initialRoute,
          ),
        );
      },
    );
  }
}
