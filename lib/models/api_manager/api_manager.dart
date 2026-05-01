// ignore_for_file: avoid_print
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:graduation_project/models/model/login_model.dart';
import 'package:graduation_project/models/model/register_model.dart';

class ApiManager {
  final Dio _dio;
  static const String _baseUrl = 'http://medicalsystem111.runasp.net/api/';

  ApiManager()
    : _dio = Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
          sendTimeout: const Duration(seconds: 60),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Connection': 'keep-alive',
          },
          responseType: ResponseType.json,
        ),
      ) {
    // Fix SSL + Force HTTP/1.1
    final adapter = _dio.httpClientAdapter;
    if (adapter is IOHttpClientAdapter) {
      adapter.createHttpClient = () {
        final client = HttpClient()
          ..badCertificateCallback = (cert, host, port) => true;

        // Force HTTP/1.1 — prevents "Connection reset by peer" on some servers
        client.userAgent = 'Dart/3.0 (dart:io)';

        return client;
      };
    }

    // Retry interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          if (_isRetryable(error) &&
              error.requestOptions.extra['retried'] != true) {
            try {
              print('Retrying request after connection error...');
              await Future.delayed(const Duration(seconds: 2));

              final opts = error.requestOptions;
              opts.extra['retried'] = true;

              final response = await _dio.request(
                opts.path,
                data: opts.data,
                queryParameters: opts.queryParameters,
                options: Options(
                  method: opts.method,
                  headers: opts.headers,
                  extra: opts.extra,
                ),
              );
              handler.resolve(response);
              return;
            } catch (e) {
              // Retry failed, continue with original error
            }
          }
          handler.next(error);
        },
      ),
    );

    // Log interceptor
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        requestHeader: true,
      ),
    );
  }

  bool _isRetryable(DioException error) {
    return error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        (error.message?.contains('Connection reset') ?? false) ||
        (error.message?.contains('Connection closed') ?? false);
  }

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final body = request.toJson();
      // ignore: duplicate_ignore
      // ignore: avoid_print
      print('Login request body: $body');

      final response = await _dio.post('Identity/AccountApi/Login', data: body);

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;

        // Server returns {token, expires} directly — wrap it in LoginResponse
        if (data.containsKey('token')) {
          return LoginResponse(
            status: true,
            message: 'Login Successful',
            data: LoginData(
              token: data['token'] as String?,
              email: null,
              fullName: null,
            ),
          );
        }

        // Handle new response format: {"message":"...","roles":["..."],"userId":"..."}
        if (data.containsKey('userId') && data.containsKey('roles')) {
          return LoginResponse(
            status: true,
            message: data['message']?.toString() ?? 'Login Successful',
            data: LoginData(token: null, email: null, fullName: null),
          );
        }

        // Fallback: server might return {status, message, data} format
        return LoginResponse.fromJson(data);
      } else {
        return LoginResponse(
          status: false,
          message: 'Unexpected response format',
        );
      }
    } on DioException catch (e) {
      print('Login DioException: ${e.type} — ${e.message}');
      if (e.response != null) {
        final data = e.response!.data;
        if (data is Map<String, dynamic>) {
          return LoginResponse(
            status: false,
            message: data['message']?.toString() ?? _friendlyError(e),
          );
        } else if (data is String && data.isNotEmpty) {
          return LoginResponse(status: false, message: data);
        }
      }
      return LoginResponse(status: false, message: _friendlyError(e));
    } catch (e) {
      print('Login error: $e');
      return LoginResponse(status: false, message: e.toString());
    }
  }

  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      final body = request.toJson();
      print('Register request body: $body');

      final response = await _dio.post(
        'Identity/AccountApi/RegisterPatient',
        data: body,
      );

      print('Register response: ${response.statusCode} — ${response.data}');
      return RegisterResponse(status: true, message: response.data.toString());
    } on DioException catch (e) {
      print('Register DioException: ${e.type} — ${e.message}');
      final data = e.response?.data;

      if (data is List) {
        final errorMessage = data
            .map((error) => error['description'].toString())
            .join('\n');
        return RegisterResponse(status: false, message: errorMessage);
      }

      if (data is Map<String, dynamic>) {
        return RegisterResponse(
          status: false,
          message: data['message']?.toString() ?? e.message ?? 'Error',
        );
      }

      return RegisterResponse(status: false, message: _friendlyError(e));
    } catch (e) {
      print('Register error: $e');
      return RegisterResponse(status: false, message: e.toString());
    }
  }

  String _friendlyError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return 'Server is taking too long to respond. Please try again.';
      case DioExceptionType.connectionError:
        return 'Could not connect to server. Please check your internet.';
      default:
        return e.message ?? 'Connection Error';
    }
  }

  Future<RegisterResponse> forgetPassword(String email) async {
    try {
      final response = await _dio.post(
        'Identity/AccountApi/ForgotPassword',
        data: {'email': email},
      );
      return RegisterResponse.fromJson(response.data);
    } catch (e) {
      return RegisterResponse(status: false, message: e.toString());
    }
  }
}
