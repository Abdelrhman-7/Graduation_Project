part of 'test_api_cubit.dart';

@immutable
sealed class TestApiState {}

final class TestApiInitial extends TestApiState {}

final class TestApiLoading extends TestApiState {
  final String? message;

  TestApiLoading({this.message});
}

final class TestApiSuccess extends TestApiState {
  final String message;

  TestApiSuccess({required this.message});
}

final class TestApiLoginSuccess extends TestApiState {}

final class TestApiError extends TestApiState {
  final String message;

  TestApiError({required this.message});
}
