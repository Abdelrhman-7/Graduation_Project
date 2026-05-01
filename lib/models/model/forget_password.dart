class ForgetResponse {
  final bool? status;
  final String? message;

  ForgetResponse({this.status, this.message});

  factory ForgetResponse.fromJson(Map<String, dynamic> json) => ForgetResponse(
    status: json['status'] as bool?,
    message: json['message'] as String?,
  );
  Map<String, dynamic> toJson() => {};
}
