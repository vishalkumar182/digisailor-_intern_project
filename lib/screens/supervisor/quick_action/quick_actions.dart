import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Widget for quick action section with a single "Add Entry" card
class QuickActionsSection extends StatelessWidget {
  final Function(String) onActionPressed;
  final List<String> actions;

  const QuickActionsSection({
    super.key,
    required this.onActionPressed,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        Container(
          width: double.infinity,
          child: Card(
            elevation: 0,
            color:
                isDarkMode ? const Color(0xFF2C2C2E) : const Color(0xFFE8ECEF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color:
                    isDarkMode
                        ? Colors.white.withOpacity(0.2)
                        : const Color(0xFFCED4DA),
                width: 1,
              ),
            ),
            child: InkWell(
              onTap: () => onActionPressed(actions[0]),
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors:
                        isDarkMode
                            ? [const Color(0xFF3A3A3C), const Color(0xFF2C2C2E)]
                            : [
                              const Color(0xFFF7F9FC),
                              const Color(0xFFE8ECEF),
                            ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.add_circled,
                      size: screenWidth * 0.08,
                      color: const Color(0xFF007AFF),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Text(
                      'Add Entry',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w600,
                        color:
                            isDarkMode ? Colors.white : const Color(0xFF1C2526),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
