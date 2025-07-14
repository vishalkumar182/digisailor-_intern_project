import 'dart:async';
import '../../models/auth/login_model.dart';

class LoginService {
  /// Simulated login function to mimic API call
  /// Currently uses dummy data but structure allows easy replacement with real API call.
  Future<String?> loginUser(LoginModel loginModel) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Dummy logic for login validation (replace with real API request)
    if (loginModel.email == 'supervisor@example.com' &&
        loginModel.password == '123456') {
      // Successful login as supervisor
      return 'supervisor';
    }

    // Return null or empty if login failed or user not found
    return null;
  }
}
