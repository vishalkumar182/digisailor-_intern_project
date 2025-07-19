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
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    setState(() => _isLoading = false);
    _showSuccessDialog('Signed up with Email');
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1)); // Simulate Google sign-in
    setState(() => _isLoading = false);
    _showSuccessDialog('Signed up with Google');
  }

  Future<void> _handleAppleSignIn() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1)); // Simulate Apple sign-in
    setState(() => _isLoading = false);
    _showSuccessDialog('Signed up with Apple');
  }

  void _showSuccessDialog(String method) {
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
                'Your account has been created using $method. Please log in.',
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
                            'Sign up using Google, Apple, or your email.',
                            style: TextStyle(
                              fontSize: screenWidth * 0.042,
                              color: const Color(0xFF6B7280),
                              height: 1.4,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.05),
                          // Google Sign-In Button
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: CupertinoButton(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              borderRadius: BorderRadius.circular(12),
                              onPressed:
                                  _isLoading ? null : _handleGoogleSignIn,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Placeholder for Google logo (replace with actual asset)
                                  Container(
                                    width: 24,
                                    height: 24,
                                    color: Colors.grey.shade200, // Placeholder
                                    child: Center(
                                      child: Image.asset(
                                        "assets/images/google.png", // Replace with your actual asset path
                                        fit: BoxFit.contain,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Continue with Google',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.045,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF1F2937),
                                      decoration: TextDecoration.none,
                                      fontFamily:
                                          'Roboto', // Google recommends Roboto
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          // Apple Sign-In Button
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF1F2937,
                              ), // Dark grey for Apple
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
                            child: CupertinoButton(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              borderRadius: BorderRadius.circular(12),
                              onPressed: _isLoading ? null : _handleAppleSignIn,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                        4,
                                      ), // Optional: Rounded corners
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/images/apple.png', // Replace with your actual path
                                        fit: BoxFit.contain,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Continue with Apple',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.045,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          // Divider
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.grey.shade400,
                                  thickness: 0.5,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Text(
                                  'OR',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    color: const Color(0xFF6B7280),
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.grey.shade400,
                                  thickness: 0.5,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          // Email/Password Fields
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
                          // Sign Up Button
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
                                  color: const Color.fromARGB(255, 4, 8, 8),
                                  fontWeight: FontWeight.w600,
                                  decoration:
                                      TextDecoration
                                          .none, // text decoration ko nuone kar diya aur line hat gaya
                                  decorationColor: const Color.fromARGB(
                                    255,
                                    2,
                                    20,
                                    17,
                                  ),
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
