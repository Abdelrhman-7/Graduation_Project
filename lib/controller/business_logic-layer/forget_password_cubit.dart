import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/api_manager/api_manager.dart';

abstract class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordSuccess extends ForgetPasswordState {
  final String message;
  ForgetPasswordSuccess(this.message);
}

class ForgetPasswordError extends ForgetPasswordState {
  final String message;
  ForgetPasswordError(this.message);
}

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ApiManager _apiService;

  ForgetPasswordCubit(this._apiService) : super(ForgetPasswordInitial());

  Future<void> forgetPassword({required String email}) async {
    emit(ForgetPasswordLoading());
    try {
      final success = await _apiService.forgetPassword(email);
      if (success.status == true) {
        emit(ForgetPasswordSuccess("Password reset link sent successfully"));
      } else {
        emit(ForgetPasswordError("Failed to send reset link"));
      }
    } catch (e) {
      emit(ForgetPasswordError(e.toString()));
    }
  }
}
