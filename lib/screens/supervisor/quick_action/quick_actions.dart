import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Widget for quick action section with a single "Add Entry" card
class QuickActionsSection extends StatelessWidget {
  final Function(String) onActionPressed;
  final List<String> actions;
  final double? height;

  const QuickActionsSection({
    super.key,
    required this.onActionPressed,
    required this.actions,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

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
        SizedBox(
          height:
              height ?? screenWidth * 0.15, // Reduced height for better balance
          child: SizedBox(
            width: double.infinity,
            child: InkWell(
              onTap: () => onActionPressed(actions[0]),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.02), // Reduced padding
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color(0xFFFF9500), const Color(0xFFFF8C00)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF9500).withOpacity(0.5),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(
                        screenWidth * 0.03,
                      ), // Reduced padding
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF9500).withOpacity(0.6),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        CupertinoIcons.add_circled,
                        size: screenWidth * 0.06, // Reduced icon size
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02), // Reduced spacing
                    Text(
                      'Add Entry',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04, // Reduced font size
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.8,
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
