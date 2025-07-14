import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Custom bottom navigation bar with animated icons
class SupervisorBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavigationBarItem> items;

  const SupervisorBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: Colors.blue.shade600,
          unselectedItemColor: Colors.grey.shade600,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 11,
          ),
          items: items,
        ),
      ),
    );
  }
}

/// Builds an animated SVG icon for bottom navigation
class BottomNavIcon extends StatelessWidget {
  final String assetPath;
  final bool isActive;

  const BottomNavIcon({
    super.key,
    required this.assetPath,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: SvgPicture.asset(assetPath, height: 24),
    );
  }
}

/// Creates the bottom navigation items with proper padding
BottomNavigationBarItem bottomNavItem({
  required String iconPath,
  required String label,
  required bool isActive,
}) {
  return BottomNavigationBarItem(
    icon: Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: BottomNavIcon(assetPath: iconPath, isActive: isActive),
    ),
    label: label,
  );
}
