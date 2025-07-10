import 'package:flutter/material.dart';
import 'screens/onboarding/onboarding_page_data.dart'; // apne project structure ke hisab se import karo

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Construction Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Onboarding(), // Yahan onboarding screen ka widget rakho
    );
  }
}
