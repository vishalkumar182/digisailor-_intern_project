import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:construction_manager_app/services/auth/forgot_password_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final ForgotPasswordService _forgotPasswordService = ForgotPasswordService();
  bool _isLoading = false;
  AnimationController? _animationController;
  Animation<double>? _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    );
    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> _handlePasswordReset() async {
    if (emailController.text.trim().isEmpty) {
      _showErrorDialog('Please enter your email address');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final success = await _forgotPasswordService.sendPasswordResetEmail(
        emailController.text.trim(),
      );

      setState(() => _isLoading = false);

      if (success) {
        _showSuccessDialog();
      } else {
        _showErrorDialog('Password reset failed. Please try again.');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showErrorDialog('An error occurred. Please try again.');
    }
  }

  void _showSuccessDialog() {
    showCupertinoDialog(
      context: context,
      builder:
          (context) => CupertinoAlertDialog(
            title: Text(
              'Reset Email Sent',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2937),
                decoration: TextDecoration.none, // Explicitly no decoration
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Check your email for instructions to reset your password',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color(0xFF6B7280),
                  decoration: TextDecoration.none, // Explicitly no decoration
                ),
              ),
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFFF6B35), // Orange for dialog action
                    decoration: TextDecoration.none, // Explicitly no decoration
                  ),
                ),
              ),
            ],
          ),
    );
  }

  void _showErrorDialog(String message) {
    showCupertinoDialog(
      context: context,
      builder:
          (context) => CupertinoAlertDialog(
            title: Text(
              'Password Reset Error',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2937),
                decoration: TextDecoration.none, // Explicitly no decoration
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  color: const Color(0xFF6B7280),
                  decoration: TextDecoration.none, // Explicitly no decoration
                ),
              ),
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFFF6B35), // Orange for dialog action
                    decoration: TextDecoration.none, // Explicitly no decoration
                  ),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF5F5F4), // Light cream background
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Forgot Password',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: const Color(0xFF1F2937),
            decoration: TextDecoration.none, // Explicitly no decoration
          ),
        ),
        backgroundColor: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100, width: 0.5),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child:
              _fadeAnimation != null
                  ? FadeTransition(
                    opacity: _fadeAnimation!,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenHeight * 0.04),
                          Text(
                            'Reset Your Password',
                            style: TextStyle(
                              fontSize: screenWidth * 0.07,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF1F2937),
                              decoration:
                                  TextDecoration
                                      .none, // Explicitly no decoration
                              letterSpacing: 0.3,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Text(
                            'Enter your email address to receive a password reset link.',
                            style: TextStyle(
                              fontSize: screenWidth * 0.042,
                              color: const Color(0xFF6B7280),
                              height: 1.4,
                              decoration:
                                  TextDecoration
                                      .none, // Explicitly no decoration
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.05),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: CupertinoTextField(
                              controller: emailController,
                              placeholder: 'Enter your email',
                              placeholderStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: screenWidth * 0.042,
                                decoration:
                                    TextDecoration
                                        .none, // Explicitly no decoration
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.transparent,
                                ), // Explicitly no border
                              ),
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                fontSize: screenWidth * 0.042,
                                color: const Color(0xFF1F2937),
                                decoration:
                                    TextDecoration
                                        .none, // Explicitly no decoration
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFFFF6B35), // Vibrant orange
                                  const Color(0xFFFF8C5A), // Lighter orange
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFFFF6B35,
                                  ).withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: CupertinoButton(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              borderRadius: BorderRadius.circular(12),
                              onPressed:
                                  _isLoading ? null : _handlePasswordReset,
                              child:
                                  _isLoading
                                      ? const CupertinoActivityIndicator(
                                        color: Colors.white,
                                      )
                                      : Text(
                                        'Send Reset Link',
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.045,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          decoration:
                                              TextDecoration
                                                  .none, // Explicitly no decoration
                                        ),
                                      ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Center(
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Text(
                                'Back to Login',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.042,
                                  color: const Color.fromARGB(
                                    255,
                                    21,
                                    21,
                                    21,
                                  ), // Teal for contrast
                                  fontWeight: FontWeight.w600,
                                  decoration:
                                      TextDecoration
                                          .none, // none kar diya aur woh yellow line chala gaya
                                  decorationColor: const Color(
                                    0xFF2DD4BF,
                                  ), // Match underline to text color
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                        ],
                      ),
                    ),
                  )
                  : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
