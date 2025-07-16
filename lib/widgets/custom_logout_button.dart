import 'package:construction_manager_app/screens/auth/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../services/auth/login_service.dart';

class CustomLogoutButton extends StatelessWidget {
  final VoidCallback? onLogout; // Callback for custom logout logic in future
  final LoginService _loginService = LoginService();

  CustomLogoutButton({super.key, this.onLogout});

  // Dummy logout function
  Future<void> _handleLogout(BuildContext context) async {
    // Clear user data via LoginService
    _loginService.clearDummyUser();

    // Navigate to login screen, clearing the navigation stack
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ), //bahar jane ke liye
        (route) => false, // Remove all previous routes
      );
    }
  }

  // Show confirmation dialog
  Future<void> _showLogoutDialog(BuildContext context) async {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            'Log Out',
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
            ),
          ),
          content: Padding(
            padding: EdgeInsets.only(top: screenWidth * 0.02),
            child: Text(
              'Are you sure you want to log out?',
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: isDarkMode ? Colors.white70 : const Color(0xFF6B7280),
              ),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF007AFF),
                ),
              ),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context); // Close dialog first
                _handleLogout(context);
                onLogout?.call();
              },
              child: Text(
                'Log Out',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFFF3B30),
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

    return CupertinoButton(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenWidth * 0.015,
      ),
      color: const Color(0xFFFF3B30),
      borderRadius: BorderRadius.circular(14),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CupertinoIcons.arrow_right_circle_fill,
            size: screenWidth * 0.04,
            color: Colors.white,
          ),
          SizedBox(width: screenWidth * 0.015),
          Text(
            'Logout',
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      onPressed: () {
        HapticFeedback.heavyImpact();
        _showLogoutDialog(context);
      },
    );
  }
}
