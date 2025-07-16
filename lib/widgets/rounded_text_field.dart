import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Color iconColor;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconButton? suffixIcon;

  const RoundedTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.iconColor,
    required this.controller,
    required this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF2C2C2E) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color:
              isDarkMode
                  ? Colors.white.withOpacity(0.2)
                  : const Color(0xFFCED4DA),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.25 : 0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: TextStyle(
          fontSize: screenWidth * 0.042,
          color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: isDarkMode ? Colors.white70 : const Color(0xFF6B7280),
            fontSize: screenWidth * 0.042,
          ),
          prefixIcon: Icon(icon, color: iconColor, size: screenWidth * 0.05),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenWidth * 0.04,
          ),
        ),
      ),
    );
  }
}
