import 'package:graduation_project/models/api_manager/api_manager.dart';
import 'package:graduation_project/models/model/login_model.dart';
import 'package:graduation_project/models/model/register_model.dart';

class Repository {
  Repository(this.apiManager);
  final ApiManager apiManager;

  Future<LoginResponse> login(String email, String password) async {
    return apiManager.login(LoginRequest(email: email, password: password));
  }

  Future<RegisterResponse> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    return apiManager.register(
      RegisterRequest(fullName: fullName, email: email, password: password),
    );
  }

  Future<RegisterResponse> forgetPassword(String email) async {
    return apiManager.forgetPassword(email);
  }
}
