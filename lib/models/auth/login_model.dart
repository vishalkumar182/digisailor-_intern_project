class LoginModel {
  final String email;
  final String password;

  LoginModel({required this.email, required this.password});

  // Dummy validation method - improve later
  bool isValid() {
    return email.contains('@') && password.length >= 6;
  }
}
