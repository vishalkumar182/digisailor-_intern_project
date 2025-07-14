import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AnimatedHeading extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Duration speed;
  final bool isRepeating;

  const AnimatedHeading({
    super.key,
    required this.text,
    this.style,
    this.speed = const Duration(milliseconds: 80),
    this.isRepeating = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AnimatedTextKit(
        animatedTexts: [
          TyperAnimatedText(
            text,
            textStyle:
                style ??
                const TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
            speed: speed,
          ),
        ],
        totalRepeatCount: isRepeating ? 1000 : 1,
        pause: const Duration(milliseconds: 500),
        displayFullTextOnTap: true,
        stopPauseOnTap: true,
      ),
    );
  }
}
