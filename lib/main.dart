import 'package:construction_manager_app/screens/auth/login_screen.dart';
import 'package:construction_manager_app/screens/supervisor/dashboard/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:construction_manager_app/theme/theme_provider.dart'; // Added for theme management

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('App started with ThemeMode.light');
    return ChangeNotifierProvider(
      // Added ChangeNotifierProvider to manage theme state
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        // Added Consumer to dynamically apply theme
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/login',
            routes: {
              '/login':
                  (context) =>
                      const LoginScreen(), // Testing route, change to LoginScreen() for production
              '/dashboard': (context) => const SupervisorDashboardScreen(),
            },
            theme: ThemeData.light().copyWith(
              scaffoldBackgroundColor: Colors.transparent,
              primaryColor: const Color(0xFF007AFF),
              textTheme: const TextTheme(
                headlineMedium: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1C2526),
                ),
                bodyMedium: TextStyle(fontSize: 16, color: Color(0xFF1C2526)),
                bodySmall: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
              ),
              cupertinoOverrideTheme: const CupertinoThemeData(
                primaryColor: Color(0xFF007AFF),
                textTheme: CupertinoTextThemeData(
                  textStyle: TextStyle(fontSize: 16, color: Color(0xFF1C2526)),
                ),
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              // Added darkTheme as a fallback for system dark mode
              primaryColor: const Color(0xFF0A84FF),
              scaffoldBackgroundColor: const Color(0xFF1C2526),
              textTheme: const TextTheme(
                headlineMedium: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white70,
                ),
                bodyMedium: TextStyle(fontSize: 16, color: Colors.white70),
                bodySmall: TextStyle(fontSize: 14, color: Colors.white54),
              ),
              cupertinoOverrideTheme: const CupertinoThemeData(
                primaryColor: Color(0xFF0A84FF),
                textTheme: CupertinoTextThemeData(
                  textStyle: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ),
            ),
            themeMode:
                themeProvider.isDarkMode
                    ? ThemeMode.dark
                    : ThemeMode.light, // Updated to use ThemeProvider's state
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: 1.0,
                ), // Ensures consistent text scaling
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
