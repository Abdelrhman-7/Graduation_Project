import 'package:flutter/material.dart';

import 'package:graduation_project/shered/resources/colors_manager.dart';
import 'package:graduation_project/shered/routes_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const graduationprojec());
}

// ignore: camel_case_types
class graduationprojec extends StatelessWidget {
  const graduationprojec({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'graduation_projec',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: ColorsManager.white,
          ),
          routes: RoutesManager.router,
          initialRoute: RoutesManager.chooseAccount,
        );
      },
    );
  }
}
