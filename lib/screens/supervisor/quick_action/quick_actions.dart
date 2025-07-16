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
              height ??
              55, // Breadth: Default height set to 60 (adjust this value as needed)
          child: SizedBox(
            width: double.infinity,
            child: InkWell(
              onTap: () => onActionPressed(actions[0]),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: EdgeInsets.all(
                  screenWidth * 0.03,
                ), // Padding for internal spacing
                decoration: BoxDecoration(
                  color:
                      isDarkMode
                          ? const Color(0xFF2C2C2E)
                          : const Color(0xFFFF9500),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color:
                          isDarkMode
                              ? Colors.black.withOpacity(0.4)
                              : const Color(0xFFFF9500).withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(
                        8,
                      ), // Padding for icon circle
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF9500),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF9500).withOpacity(0.6),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(
                        CupertinoIcons.add_circled,
                        size: screenWidth * 0.08, // Icon size
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.03,
                    ), // Spacing between icon and text
                    Text(
                      'Add Entry',
                      style: TextStyle(
                        fontSize: screenWidth * 0.055, // Text font size
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 1.0,
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
