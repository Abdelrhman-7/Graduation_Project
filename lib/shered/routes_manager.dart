import 'package:flutter/widgets.dart';
import 'package:graduation_project/features/auth/view/registe_screen.dart';
import 'package:graduation_project/features/auth/view/login_screen.dart';

class RoutesManager {
  static String chooseAccount = "/chooseAccount";
  static String login = "/login";
  static Map<String, WidgetBuilder> router = {
    chooseAccount: (context) => ChooseAccount(),
    login: (context) => LoginScreen(),
  };
}
