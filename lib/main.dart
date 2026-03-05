import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/controller/business_logic-layer/test_api_cubit.dart';
import 'package:graduation_project/models/api_manager/api_manager.dart';
import 'package:graduation_project/models/model/shered_pref_controller/shered_pref_controler.dart';
import 'package:graduation_project/models/repository/repository.dart';
import 'package:graduation_project/shered_widgites/routes_manager.dart';
import 'package:graduation_project/controller/business_logic-layer/find_doctor_cubit.dart';
import 'package:graduation_project/controller/business_logic-layer/pharmacy_cubit.dart';

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
      designSize: const Size(375, 812), // نفس حجم التصميم
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => Repository(ApiManager())),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => TestApiCubit(context.read<Repository>()),
              ),
              BlocProvider(
                create: (context) => FindDoctorCubit()..loadDoctors(),
              ),
              BlocProvider(
                create: (context) => PharmacyCubit()..loadPrescription(),
              ),
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
          ),
        );
      },
    );
  }
}
