import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      _showErrorDialog('Please fill in all fields');
      return;
    }

    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      _showErrorDialog('Passwords do not match');
      return;
    }

    setState(() => _isLoading = true);

    // Dummy signup logic for UI testing
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    setState(() => _isLoading = false);

    // Always show success for dummy data
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showCupertinoDialog(
      context: context,
      builder:
          (context) => CupertinoAlertDialog(
            title: Text(
              'Sign Up Successful',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2937),
                decoration: TextDecoration.none,
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Your account has been created. Please log in.',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color(0xFF6B7280),
                  decoration: TextDecoration.none,
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
                    color: const Color(0xFFFF6B35),
                    decoration: TextDecoration.none,
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
              'Sign Up Error',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2937),
                decoration: TextDecoration.none,
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  color: const Color(0xFF6B7280),
                  decoration: TextDecoration.none,
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
                    color: const Color(0xFFFF6B35),
                    decoration: TextDecoration.none,
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
      backgroundColor: const Color(0xFFF5F5F4),
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Sign Up',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: const Color(0xFF1F2937),
            decoration: TextDecoration.none,
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
                            'Create Your Account',
                            style: TextStyle(
                              fontSize: screenWidth * 0.07,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF1F2937),
                              decoration: TextDecoration.none,
                              letterSpacing: 0.3,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Text(
                            'Enter your details to sign up.',
                            style: TextStyle(
                              fontSize: screenWidth * 0.042,
                              color: const Color(0xFF6B7280),
                              height: 1.4,
                              decoration: TextDecoration.none,
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
                                decoration: TextDecoration.none,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.transparent),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                fontSize: screenWidth * 0.042,
                                color: const Color(0xFF1F2937),
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
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
                              controller: passwordController,
                              placeholder: 'Enter your password',
                              placeholderStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: screenWidth * 0.042,
                                decoration: TextDecoration.none,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.transparent),
                              ),
                              obscureText: true,
                              style: TextStyle(
                                fontSize: screenWidth * 0.042,
                                color: const Color(0xFF1F2937),
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
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
                              controller: confirmPasswordController,
                              placeholder: 'Confirm your password',
                              placeholderStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: screenWidth * 0.042,
                                decoration: TextDecoration.none,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.transparent),
                              ),
                              obscureText: true,
                              style: TextStyle(
                                fontSize: screenWidth * 0.042,
                                color: const Color(0xFF1F2937),
                                decoration: TextDecoration.none,
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
                                  const Color(0xFFFF6B35),
                                  const Color(0xFFFF8C5A),
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
                              onPressed: _isLoading ? null : _handleSignUp,
                              child:
                                  _isLoading
                                      ? const CupertinoActivityIndicator(
                                        color: Colors.white,
                                      )
                                      : Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.045,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
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
                                  color: const Color.fromARGB(255, 1, 16, 16),
                                  fontWeight: FontWeight.w600,

                                  decorationThickness: 1.5,
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
