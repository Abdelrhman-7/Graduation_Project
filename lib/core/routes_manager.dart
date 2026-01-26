import 'package:flutter/widgets.dart';
import 'package:graduation_project/features/auth/ui/choose%20_account.dart';

class RoutesManager {
  static String chooseAccount = "/chooseAccount";
  static Map<String, WidgetBuilder> router = {
    chooseAccount: (context) => ChooseAccount(),
  };
}
