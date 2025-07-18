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
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1F1F1F) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color:
              isDarkMode
                  ? Colors.white.withOpacity(0.15)
                  : const Color(0xFFE0E0E0),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color:
                isDarkMode
                    ? Colors.black.withOpacity(0.5)
                    : Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
            spreadRadius: 1,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: TextStyle(
          fontSize: screenWidth * 0.045,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        cursorColor: isDarkMode ? Colors.white : Colors.black,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: isDarkMode ? Colors.white70 : Colors.grey[600],
            fontSize: screenWidth * 0.045,
          ),
          prefixIcon: Icon(icon, color: iconColor, size: screenWidth * 0.055),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.045,
            vertical: screenWidth * 0.045,
          ),
        ),
      ),
    );
  }
}
