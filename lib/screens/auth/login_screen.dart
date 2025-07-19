// ignore_for_file: library_private_types_in_public_api

import 'package:construction_manager_app/screens/auth/forget_password_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:construction_manager_app/widgets/rounded_text_field.dart';
import 'package:construction_manager_app/models/auth/login_model.dart';
import 'package:construction_manager_app/services/auth/login_service.dart';
import 'package:construction_manager_app/screens/auth/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginService _loginService = LoginService();
  bool _isLoading = false;
  bool _obscureText = true;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _animationController.dispose();
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
    _animationController.repeat();

    try {
      debugPrint('Attempting login with: ${loginModel.email}');
      final result = await _loginService.loginUser(loginModel);
      setState(() => _isLoading = false);
      _animationController.stop();

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
      _animationController.stop();
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
    final bool isSmallScreen = screenHeight < 700;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF7F9FC), Color(0xFFE8ECEF)],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: screenHeight - MediaQuery.of(context).padding.top,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animation and Header Section - Optimized spacing
                    Padding(
                      padding: EdgeInsets.only(top: isSmallScreen ? 15 : 20),
                      child: Column(
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight:
                                  isSmallScreen
                                      ? screenHeight * 0.25
                                      : screenHeight * 0.23,
                            ),
                            child: Lottie.asset(
                              'assets/animations/construction_site4.json',
                              width: screenWidth * 0.9,
                              controller: _animationController,
                              onLoaded: (composition) {
                                _animationController
                                  ..duration = composition.duration
                                  ..forward();
                              },
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 8 : 12),
                          Text(
                            'Construction Manager',
                            style: TextStyle(
                              fontSize: screenWidth * 0.065,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF1C2526),
                              letterSpacing: -0.5,
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 4 : 6),
                          Text(
                            'Login to manage your projects',
                            style: TextStyle(
                              fontSize: screenWidth * 0.038,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Form Section - Reduced spacing
                    Padding(
                      padding: EdgeInsets.only(
                        top: isSmallScreen ? 15 : 20,
                        bottom: 15,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                          vertical: screenWidth * 0.04,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
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
                            SizedBox(height: screenHeight * 0.015),
                            Align(
                              alignment: Alignment.centerRight,
                              child: CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  HapticFeedback.lightImpact();
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder:
                                          (context) =>
                                              const ForgotPasswordScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.035,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF007AFF),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Sign In Button - Adjusted padding
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoButton(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.018,
                        ),
                        color: const Color.fromARGB(255, 255, 123, 0),
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
                                ? const CupertinoActivityIndicator(
                                  radius: 14,
                                  color: Colors.white,
                                )
                                : Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.045,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                      ),
                    ),

                    // Sign Up Section - Reduced spacing
                    Padding(
                      padding: EdgeInsets.only(
                        top: 12,
                        bottom: isSmallScreen ? 20 : 25,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              fontSize: screenWidth * 0.038,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF6B7280),
                            ),
                          ),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              debugPrint('Navigate to signup screen');

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ), // Replace with your actual Signup screen class
                              );
                            },

                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: screenWidth * 0.038,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF007AFF),
                              ),
                            ),
                          ),
                        ],
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
