import 'package:flutter/material.dart';
import 'package:graduation_project/core/resources/colors_manager.dart';
import 'package:graduation_project/core/routes_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: ColorsManager.white,
      ),

      routes: RoutesManager.router,

      initialRoute: RoutesManager.chooseAccount,
    );
  }
}
