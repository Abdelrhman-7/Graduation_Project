import 'package:dio/dio.dart';
import 'package:graduation_project/models/api_manager/custome_eception.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final message = _handleError(err);
    handler.reject(
      err.copyWith(
        error: ApiException(
          message: message,
          statusCode: err.response?.statusCode,
        ),
      ),
    );
  }

  String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return "Connection Timeout";
      case DioExceptionType.connectionError:
        return "No Internet Connection";
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case 400:
            return "Bad Request";
          case 401:
            return "Unauthorized";
          case 404:
            return "Not Found";
          case 500:
            return "Internal Server Error";
          default:
            return "Server Error";
        }
      default:
        return "Unexpected Error";
    }
  }
}
