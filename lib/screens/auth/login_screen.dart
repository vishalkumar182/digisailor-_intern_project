import 'package:flutter/material.dart';
import 'package:construction_manager_app/widgets/animated_heading.dart';
import 'package:construction_manager_app/widgets/rounded_text_field.dart';
import 'package:construction_manager_app/widgets/rounded_button.dart';
import 'package:construction_manager_app/models/auth/login_model.dart';
import 'package:construction_manager_app/widgets/animations/login_animation_widget.dart'; // Custom Lottie animation widget
import 'package:construction_manager_app/services/auth/login_service.dart';
import 'package:construction_manager_app/screens/supervisor/dashboard/dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers to capture user input for email and password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Service class instance to handle login related API calls
  final LoginService _loginService = LoginService();

  // To show a loading indicator while login request is being processed
  bool _isLoading = false;

  @override
  void dispose() {
    // Dispose controllers to free resources when widget is removed from tree
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Method to handle login button press
  Future<void> _handleLogin() async {
    // Create login data model with trimmed inputs
    final loginModel = LoginModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    // Basic client-side validation before sending request to server
    if (!loginModel.isValid()) {
      _showSnackBar('Please enter a valid email and password (6+ chars)');
      return;
    }

    // Show loading indicator while waiting for login response
    setState(() => _isLoading = true);

    try {
      // Call login service - this is a dummy or API call that returns user type string
      final userType = await _loginService.loginUser(loginModel);

      // Hide loading indicator after response received
      setState(() => _isLoading = false);

      // Only allow 'supervisor' user type to login
      if (userType == 'supervisor') {
        _navigateTo(const SupervisorDashboardScreen());
      } else {
        // Show error if user is not authorized or credentials are invalid
        _showSnackBar('Invalid credentials or unauthorized user');
      }
    } catch (e) {
      // Handle network or other errors gracefully
      setState(() => _isLoading = false);
      _showSnackBar('Login failed. Please try again.');
    }
  }

  // Helper method to navigate to another screen and replace current one
  void _navigateTo(Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  // Helper method to show snackbar messages
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset to prevent overflow when keyboard appears
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          // Padding around the content
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom Lottie animation widget for login screen
              const LoginAnimationWidget(),

              const SizedBox(height: 20),

              // Animated welcome text
              const AnimatedHeading(text: "Welcome Back!"),

              const SizedBox(height: 40),

              // Email input field with rounded style
              RoundedTextField(
                hintText: 'Email',
                icon: Icons.email,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              // Password input field with rounded style and obscured text
              RoundedTextField(
                hintText: 'Password',
                icon: Icons.lock,
                obscureText: true,
                controller: passwordController,
                keyboardType: TextInputType.text,
              ),

              const SizedBox(height: 30),

              // Show loading indicator if login in progress, else show login button
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : RoundedButton(label: 'Login', onPressed: _handleLogin),

              const SizedBox(height: 20),

              // Text button to navigate to signup screen (to be implemented)
              Center(
                child: TextButton(
                  onPressed: () {
                    // TODO: Navigate to Signup screen
                  },
                  child: const Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(color: Color(0xFF495057)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
