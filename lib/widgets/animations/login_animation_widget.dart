import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginAnimationWidget extends StatelessWidget {
  const LoginAnimationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Lottie.asset(
        'assets/animations/login_animation.json',
        fit: BoxFit.contain,
        repeat: true,
        animate: true,
      ),
    );
  }
}
