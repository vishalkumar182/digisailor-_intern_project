import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppleSubmitButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final bool enabled;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double height;
  final double fontSize;
  final IconData? icon;
  final double? iconSize;

  const AppleSubmitButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.enabled = true,
    required this.backgroundColor,
    required this.textColor,
    this.borderRadius = 16,
    this.height = 56,
    required this.fontSize,
    this.icon,
    this.iconSize,
  }) : super(key: key);

  @override
  State<AppleSubmitButton> createState() => _AppleSubmitButtonState();
}

class _AppleSubmitButtonState extends State<AppleSubmitButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTapDown: (_) {
        if (widget.enabled) _animationController.forward();
      },
      onTapUp: (_) {
        if (widget.enabled) _animationController.reverse();
      },
      onTapCancel: () {
        if (widget.enabled) _animationController.reverse();
      },
      onTap: widget.enabled ? widget.onPressed : null,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color:
                widget.enabled
                    ? widget.backgroundColor
                    : widget.backgroundColor.withOpacity(0.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  color: widget.textColor,
                  size: widget.iconSize ?? widget.fontSize * 1.2,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.text,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
