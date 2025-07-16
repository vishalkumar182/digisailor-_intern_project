// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:construction_manager_app/widgets/rounded_text_field.dart';
import 'package:construction_manager_app/models/auth/login_model.dart';
import 'package:construction_manager_app/services/auth/login_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginService _loginService = LoginService();
  bool _isLoading = false;
  bool _obscureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final loginModel = LoginModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      userType: 'supervisor',
    );

    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      debugPrint('Login failed: Empty email or password');
      _showErrorDialog('Email and Password are required.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      debugPrint('Attempting login with: ${loginModel.email}');
      final result = await _loginService.loginUser(loginModel);
      setState(() => _isLoading = false);

      if (result != null && result.userType == 'supervisor') {
        debugPrint('Login successful, navigating to /dashboard');
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/dashboard');
        }
      } else {
        debugPrint('Login failed: Invalid credentials');
        _showErrorDialog('Invalid email or password.');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint('Login error: $e');
      _showErrorDialog('Login failed. Please try again.');
    }
  }

  Future<void> _showErrorDialog(String message) async {
    final screenWidth = MediaQuery.of(context).size.width;

    return showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            'Login Error',
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1C2526),
            ),
          ),
          content: Padding(
            padding: EdgeInsets.only(top: screenWidth * 0.02),
            child: Text(
              message,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: const Color(0xFF6B7280),
              ),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF007AFF),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    debugPrint('Rendering LoginScreen with gradient background');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFD3E0EA), Color(0xFFB0C4DE)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.06,
                vertical: screenHeight * 0.04,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: screenHeight * 0.05),
                    Text(
                      'Construction Manager',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1C2526),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      'Sign in to manage your projects',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8ECEF),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFFCED4DA),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          RoundedTextField(
                            hintText: 'Email',
                            icon: CupertinoIcons.envelope_fill,
                            iconColor: const Color(0xFF007AFF),
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          RoundedTextField(
                            hintText: 'Password',
                            icon: CupertinoIcons.lock_fill,
                            iconColor: const Color(0xFFFF9500),
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _obscureText,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? CupertinoIcons.eye_slash_fill
                                    : CupertinoIcons.eye_fill,
                                color: const Color(0xFF007AFF),
                                size: screenWidth * 0.05,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    CupertinoButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.06,
                        vertical: screenWidth * 0.015,
                      ),
                      color: const Color(0xFF007AFF),
                      borderRadius: BorderRadius.circular(14),
                      onPressed:
                          _isLoading
                              ? null
                              : () {
                                HapticFeedback.lightImpact();
                                _handleLogin();
                              },
                      child:
                          _isLoading
                              ? const CupertinoActivityIndicator(radius: 12)
                              : Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextButton(
                      onPressed: () {
                        debugPrint('Navigate to signup screen');
                      },
                      child: Text(
                        "Don't have an account? Sign up",
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF007AFF),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
