import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const RoundedButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return CupertinoButton(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenWidth * 0.015,
      ),
      color: const Color(0xFF007AFF),
      borderRadius: BorderRadius.circular(14),
      onPressed: () {
        HapticFeedback.lightImpact();
        onPressed();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CupertinoIcons.checkmark_circle_fill,
            size: screenWidth * 0.04,
            color: Colors.white,
          ),
          SizedBox(width: screenWidth * 0.015),
          Text(
            label,
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
