class LoginModel {
  final String email;
  final String password;
  final String? userType;

  LoginModel({required this.email, required this.password, this.userType});

  bool isValid() {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email.trim()) && password.trim().length >= 6;
  }
}
