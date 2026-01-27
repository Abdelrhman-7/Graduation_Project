import 'package:flutter/widgets.dart';
import 'package:graduation_project/features/auth/ui/choose%20_account.dart';
import 'package:graduation_project/features/auth/ui/login_screen.dart';

class RoutesManager {
  static String chooseAccount = "/chooseAccount";
  static String login = "/login";
  static Map<String, WidgetBuilder> router = {
    chooseAccount: (context) => ChooseAccount(),
    login: (context) => LoginScreen(),
  };
}
