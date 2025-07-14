import 'package:construction_manager_app/screens/supervisor/timesheet/add_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuickActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const QuickActionButton({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.2), width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuickActionsSection extends StatelessWidget {
  final Function(String) onActionPressed;

  const QuickActionsSection({super.key, required this.onActionPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          _buildActionButtonsRow(
            firstButton: QuickActionButton(
              title: 'Add Entry',
              icon: Icons.plus_one_rounded,
              color: const Color(0xFF34C759),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => const TimesheetForm(title: 'Add Entry'),
                  ),
                );
              },
            ),
            secondButton: QuickActionButton(
              title: 'Safety Check',
              icon: Icons.shield_rounded,
              color: const Color(0xFFFF9500),
              onTap: () => onActionPressed('safety_check'),
            ),
          ),
          const SizedBox(height: 12),
          _buildActionButtonsRow(
            firstButton: QuickActionButton(
              title: 'Reports',
              icon: Icons.bar_chart_rounded,
              color: const Color(0xFF5856D6),
              onTap: () => onActionPressed('reports'),
            ),
            secondButton: QuickActionButton(
              title: 'Messages',
              icon: Icons.message_rounded,
              color: const Color(0xFF007AFF),
              onTap: () => onActionPressed('messages'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtonsRow({
    required Widget firstButton,
    required Widget secondButton,
  }) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(child: firstButton),
          const SizedBox(width: 8),
          Expanded(child: secondButton),
        ],
      ),
    );
  }
}
