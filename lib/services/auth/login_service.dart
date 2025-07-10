import 'package:construction_manager_app/models/auth/login_model.dart';
import 'package:flutter/material.dart';

/// Service class responsible for handling login logic for different user types
/// Currently uses dummy data for validation
/// Future: Replace with actual API integration
class LoginService {
  /// Simulates a login request with dummy delay and credential check
  ///
  /// [loginData] — contains email and password to validate
  ///
  /// Returns a [Future<String?>]:
  /// - `'admin'` if admin credentials match
  /// - `'supervisor'` if supervisor credentials match
  /// - `null` if no match found
  Future<String?> loginUser(LoginModel loginData) async {
    // Log attempted email in debug console
    debugPrint('Attempting login for: ${loginData.email}');

    // Simulate network delay (2 seconds) as placeholder for actual API call
    await Future.delayed(const Duration(seconds: 2));

    // Dummy credential check for Admin login
    if (loginData.email == 'admin@example.com' &&
        loginData.password == '123456') {
      debugPrint('Admin login successful');
      return 'admin';
    }
    // Dummy credential check for Supervisor login
    else if (loginData.email == 'supervisor@example.com' &&
        loginData.password == '123456') {
      debugPrint('Supervisor login successful');
      return 'supervisor';
    }
    // If no match found, return null
    else {
      debugPrint('Login failed');
      return null;
    }
  }
}
