class SignUpRequestBody {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String phone;
  final String address;
  final String age;
  final String role = "customer";

  SignUpRequestBody({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    required this.age,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'address': address,
        'age': age,
        'role': role,
        'password_confirmation': passwordConfirmation,
      };
}
