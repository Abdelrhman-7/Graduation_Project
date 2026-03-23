import 'package:graduation_project/models/api_manager/api_manager.dart';
import 'package:graduation_project/models/model/response_api.dart';

class Repository {
  Repository(this.apiManager);
  final ApiManager apiManager;

  Future<ResponseApi> login(String email, String password) async {
    try {
      final response = await apiManager.login(email, password);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> forgetPassword({required String email}) async {
    try {
      final response = await apiManager.forgetPassword(email: email);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> register({
    required String email,
    required String password,
    required String confirmPassword,
    required String userName,
    required String mobileNumber,
    required String countryMobileCode,
    required String profilePicture,
  }) async {
    try {
      final response = await apiManager.register(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        userName: userName,
        mobileNumber: mobileNumber,
        countryMobileCode: countryMobileCode,
        profilePicture: profilePicture,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
