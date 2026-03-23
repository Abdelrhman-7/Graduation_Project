import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  Future<void> saveEmail(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("Email", value);
  }

  Future<String?> getPassowrd() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("Passowrd");
  }
}
