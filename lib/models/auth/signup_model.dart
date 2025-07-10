class SignUpModel {
  final String name;
  final String email;
  final String password;

  SignUpModel({
    required this.name,
    required this.email,
    required this.password,
  });

  bool isValid() {
    return name.isNotEmpty && email.contains('@') && password.length >= 6;
  }

  // Map to JSON (for API call later)
  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'password': password};
  }
}
