import 'dart:convert';

class ResetPasswordRequest {
  String email;
  String newpassword;

  ResetPasswordRequest({required this.email, required this.newpassword});

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      ResetPasswordRequest(
          email: json["email"], newpassword: json["new_password"]);

  Map<String, dynamic> toJson() =>
      {"email": email, "new_password": newpassword};
}
