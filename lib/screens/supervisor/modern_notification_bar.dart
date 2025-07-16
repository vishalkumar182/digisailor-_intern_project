import 'package:flutter/material.dart';

class ModernNotificationBar extends StatefulWidget {
  final String title;
  final String message;
  final int count;
  final VoidCallback onClose;

  const ModernNotificationBar({
    super.key,
    required this.title,
    required this.message,
    required this.count,
    required this.onClose,
  });

  @override
  State<ModernNotificationBar> createState() => _ModernNotificationBarState();
}

class _ModernNotificationBarState extends State<ModernNotificationBar>
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
      child: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dy > 0) {
            _dismiss();
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(12),
          constraints: BoxConstraints(
            maxHeight: 80, // Limit height to prevent overflow
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF007AFF).withOpacity(0.9), // Solid background
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.notifications_active, color: Colors.white, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${widget.message} ($widget.count unread)',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 20, color: Colors.white),
                onPressed: _dismiss,
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
