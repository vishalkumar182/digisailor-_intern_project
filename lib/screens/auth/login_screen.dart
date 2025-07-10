import 'package:flutter/material.dart';
import 'package:construction_manager_app/widgets/animated_heading.dart';
import 'package:construction_manager_app/widgets/rounded_text_field.dart';
import 'package:construction_manager_app/widgets/rounded_button.dart';
import 'package:construction_manager_app/models/auth/login_model.dart';
import 'package:lottie/lottie.dart';
import 'package:construction_manager_app/services/auth/login_service.dart';
import 'package:construction_manager_app/screens/admin/dashboard/dashboard.dart';
import 'package:construction_manager_app/screens/supervisor/dashboard/dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers for email and password input fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Instantiate the LoginModel (initially empty)
  LoginModel loginModel = LoginModel(email: '', password: '');

  // Dispose controllers when not needed to avoid memory leaks
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final LoginService _loginService = LoginService();

  void _handleLogin() async {
    // Create a LoginModel instance using trimmed inputs from the text controllers
    loginModel = LoginModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    // Validate the loginModel locally before making any server request
    if (loginModel.isValid()) {
      // Since API integration is pending, we're calling a dummy login method that simulates login
      // Future: Replace _loginService.loginUser with actual API call passing loginModel data
      String? userType = await _loginService.loginUser(loginModel);

      // Check the returned user type and navigate accordingly
      if (userType == 'admin') {
        debugPrint("Admin Login Successful — Navigate to Admin Dashboard");

        // Navigate to Admin Dashboard screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminDashboardScreen()),
        );
      } else if (userType == 'supervisor') {
        debugPrint(
          "Supervisor Login Successful — Navigate to Supervisor Dashboard",
        );

        // Navigate to Supervisor Dashboard screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SupervisorDashboardScreen(),
          ),
        );
      } else {
        // If login failed due to invalid credentials (from dummy or API), show a SnackBar to the user
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Invalid credentials')));
      }
    } else {
      // If the local validation failed (email format or password length), notify the user immediately
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email and password (6+ chars)'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
                MainAxisAlignment.center, // Center vertically all content

            children: [
              // Lottie animation at the top
              SizedBox(
                height: 200,
                child: Align(
                  alignment: Alignment(
                    0.02,
                    0,
                  ), // 0.0 is center, 1.0 is right edge; 0.3 is thoda right shift
                  child: Lottie.asset('assets/animations/login_animation.json'),
                ),
              ),

              // Animated heading widget for nice welcome text
              const AnimatedHeading(text: "Welcome Back!"),

              const SizedBox(height: 40),

              // Email input field with rounded design
              RoundedTextField(
                hintText: 'Email',
                icon: Icons.email,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              // Password input field with hide/show feature
              RoundedTextField(
                hintText: 'Password',
                icon: Icons.lock,
                obscureText: true,
                controller: passwordController,
                keyboardType: TextInputType.text,
              ),

              const SizedBox(height: 30),

              // Login button triggers validation and login flow
              RoundedButton(label: 'Login', onPressed: _handleLogin),

              const SizedBox(height: 20),

              // Signup redirect text button
              Center(
                child: TextButton(
                  onPressed: () {
                    debugPrint("Navigate to Sign Up Screen");
                    // TODO: Implement navigation to signup screen
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
