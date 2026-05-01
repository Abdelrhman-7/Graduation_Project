import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/api_manager/api_manager.dart';
import 'package:graduation_project/models/model/register_model.dart';

// ─── States ───────────────────────────────────────────────────────────────────

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String? message;
  RegisterSuccess(this.message);
}

class RegisterError extends RegisterState {
  final String message;
  RegisterError(this.message);
}

// ─── Cubit ────────────────────────────────────────────────────────────────────

class RegisterCubit extends Cubit<RegisterState> {
  final ApiManager _apiService;

  RegisterCubit(this._apiService) : super(RegisterInitial());

  Future<void> register(RegisterRequest request) async {
    emit(RegisterLoading());
    try {
      // The ASP.NET backend uses fullName as UserName — spaces cause 400 errors
      final sanitizedRequest = RegisterRequest(
        fullName: request.fullName.replaceAll(' ', ''),
        email: request.email,
        password: request.password,
      );

      final result = await _apiService.register(sanitizedRequest);

      if (result.status == true) {
        emit(RegisterSuccess(result.message));
      } else {
        emit(RegisterError(result.message ?? 'Registration failed'));
      }
    } catch (e) {
      print('Register error: $e');
      emit(RegisterError(e.toString()));
    }
  }
}
