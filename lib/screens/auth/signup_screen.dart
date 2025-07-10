import 'package:flutter/material.dart';
import 'package:construction_manager_app/widgets/animated_heading.dart';
import 'package:construction_manager_app/widgets/rounded_text_field.dart';
import 'package:construction_manager_app/widgets/rounded_button.dart';
import 'package:lottie/lottie.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Text Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    debugPrint("Name: ${nameController.text}");
    debugPrint("Email: ${emailController.text}");
    debugPrint("Password: ${passwordController.text}");

    // TODO: Later integrate backend API here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Lottie animation at top
                SizedBox(
                  height: 200,
                  child: Lottie.asset(
                    'assets/animations/signup_animation.json',
                  ),
                ),

                const AnimatedHeading(text: "Create Account!"),
                const SizedBox(height: 30),

                RoundedTextField(
                  hintText: 'Full Name',
                  icon: Icons.person,
                  controller: nameController,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 20),

                RoundedTextField(
                  hintText: 'Email',
                  icon: Icons.email,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                RoundedTextField(
                  hintText: 'Password',
                  icon: Icons.lock,
                  obscureText: true,
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 30),

                RoundedButton(label: 'Sign Up', onPressed: _handleSignUp),
                const SizedBox(height: 20),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Go back to LoginScreen
                    },
                    child: const Text(
                      'Already have an account? Login',
                      style: TextStyle(color: Color(0xFF495057)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
