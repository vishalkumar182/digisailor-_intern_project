import 'package:flutter/material.dart';

class NotificationData {
  final String title;
  final String message;
  final IconData icon;
  final Color color;

  const NotificationData({
    required this.title,
    required this.message,
    this.icon = Icons.notifications,
    this.color = Colors.blue,
  });
}

class NotificationBar extends StatefulWidget {
  final NotificationData notification;
  final VoidCallback onClose;

  const NotificationBar({
    super.key,
    required this.notification,
    required this.onClose,
  });

  @override
  State<NotificationBar> createState() => _NotificationBarState();
}

class _NotificationBarState extends State<NotificationBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _dismiss() async {
    await _controller.reverse();
    widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.notification.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: widget.notification.color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(widget.notification.icon, color: widget.notification.color),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.notification.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.notification.color,
                    ),
                  ),
                  Text(widget.notification.message),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: _dismiss,
              iconSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}
