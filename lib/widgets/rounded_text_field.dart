import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;

  const RoundedTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    required this.controller,
    required TextInputType keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
