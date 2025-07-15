import 'package:construction_manager_app/screens/supervisor/dashboard/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:construction_manager_app/screens/auth/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('App started with ThemeMode.light');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const SupervisorDashboardScreen(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.transparent,
        primaryColor: const Color(0xFF007AFF),
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1C2526),
          ),
          bodyMedium: TextStyle(fontSize: 16, color: const Color(0xFF1C2526)),
          bodySmall: TextStyle(fontSize: 14, color: const Color(0xFF6B7280)),
        ),
        cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: const Color(0xFF007AFF),
          textTheme: CupertinoTextThemeData(
            textStyle: TextStyle(fontSize: 16, color: const Color(0xFF1C2526)),
          ),
        ),
      ),
      themeMode: ThemeMode.light,
    );
  }
}
