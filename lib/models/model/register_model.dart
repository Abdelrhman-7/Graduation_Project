class RegisterRequest {
  final String fullName;
  final String email;
  final String password;

  RegisterRequest({
    required this.fullName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'email': email,
    'password': password,
  };
}

class RegisterResponse {
  final bool? status;
  final String? message;

  RegisterResponse({this.status, this.message});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        status: json['status'] as bool?,
        message: json['message'] as String?,
      );
}
