import 'package:dio/dio.dart';
import 'package:graduation_project/constant/api_constant.dart';
import 'package:graduation_project/models/api_manager/custome_eception.dart';
import 'package:graduation_project/models/model/response_api.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiManager {
  final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: ApiConstant.baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
          ),
        )
        ..interceptors.add(
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseHeader: false,
          ),
        );
  Future<ResponseApi> login(String email, String password) async {
    try {
      final response = await dio.post(
        "/customers/login",
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ResponseApi.fromJson(response.data);
      } else {
        throw ApiException(
          message: "Login Failed",
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
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
      final response = await dio.post(
        "/customers/register",
        data: {
          "user_name": userName,
          "country_mobile_code": countryMobileCode,
          "mobile_number": mobileNumber,
          "email": email,
          "password": password,
          "profile_picture": profilePicture,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['message'];
      } else {
        throw ApiException(
          message: "Register Failed",
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<String> forgetPassword({required String email}) async {
    try {
      final response = await dio.post(
        "/customers/forgetPassword",
        data: {"email": email},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['message'];
      } else {
        throw ApiException(
          message: "Forget Password Failed",
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  ApiException _handleDioError(DioException e) {
    String errorMessage = "Unexpected Error";
    if (e.response != null && e.response!.data is Map) {
      errorMessage =
          e.response!.data['message'] ??
          e.response!.statusMessage ??
          "Server Error ${e.response!.statusCode}";
    } else {
      errorMessage = e.message ?? "Network Error";
    }
    return ApiException(
      message: errorMessage,
      statusCode: e.response?.statusCode,
    );
  }
}
