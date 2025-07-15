import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppleDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T> onChanged;
  final String Function(T) itemLabel;
  final double borderRadius;
  final double dropdownMaxHeight;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Duration animationDuration;
  final String? hint;
  final Widget? prefixIcon;
  final bool enabled;
  final BoxDecoration dropdownDecoration;

  const AppleDropdown({
    Key? key,
    required this.items,
    required this.onChanged,
    required this.itemLabel,
    this.selectedItem,
    this.borderRadius = 16,
    this.dropdownMaxHeight = 200,
    this.backgroundColor,
    this.textStyle,
    this.animationDuration = const Duration(milliseconds: 400),
    this.hint,
    this.prefixIcon,
    this.enabled = true,
    required this.dropdownDecoration,
  }) : super(key: key);

  @override
  State<AppleDropdown<T>> createState() => _AppleDropdownState<T>();
}

class _AppleDropdownState<T> extends State<AppleDropdown<T>>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    if (!widget.enabled) return;

    HapticFeedback.lightImpact();
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    final textColor =
        widget.enabled
            ? (isDark ? Colors.white : Colors.black)
            : (isDark ? const Color(0xFF8E8E93) : const Color(0xFF8E8E93));
    final hintColor =
        isDark ? const Color(0xFF8E8E93) : const Color(0xFF8E8E93);

    return GestureDetector(
      onTap: _toggleDropdown,
      behavior: HitTestBehavior.translucent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: widget.dropdownDecoration.copyWith(
          border: Border.all(
            color:
                _isOpen
                    ? const Color(0xFF007AFF)
                    : (isDark
                        ? const Color(0xFF38383A)
                        : const Color(0xFFD1D1D6)),
            width: _isOpen ? 2 : 1,
          ),
        ),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Column(
            children: [
              // Dropdown Header
              Container(
                height: screenWidth * 0.14,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    if (widget.prefixIcon != null) ...[
                      widget.prefixIcon!,
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: Text(
                        widget.selectedItem == null
                            ? (widget.hint ?? 'Select an option')
                            : widget.itemLabel(widget.selectedItem!),
                        style:
                            widget.textStyle ??
                            TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w500,
                              color:
                                  widget.selectedItem == null
                                      ? hintColor
                                      : textColor,
                              letterSpacing: -0.2,
                              height: 1.2,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    AnimatedRotation(
                      turns: _isOpen ? 0.5 : 0,
                      duration: widget.animationDuration,
                      curve: Curves.easeInOut,
                      child: Icon(
                        CupertinoIcons.chevron_down,
                        size: screenWidth * 0.06,
                        color:
                            widget.enabled
                                ? (isDark
                                    ? const Color(0xFF8E8E93)
                                    : const Color(0xFF8E8E93))
                                : (isDark
                                    ? const Color(0xFF48484A)
                                    : const Color(0xFFC7C7CC)),
                      ),
                    ),
                  ],
                ),
              ),
              // Dropdown Items (Expanded when open)
              SizeTransition(
                sizeFactor: _expandAnimation,
                axisAlignment: -1,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: widget.dropdownMaxHeight,
                    ),
                    decoration: BoxDecoration(
                      color: widget.dropdownDecoration.color,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(widget.borderRadius),
                      ),
                      border: Border.all(
                        color:
                            isDark
                                ? const Color(0xFF38383A)
                                : const Color(0xFFE5E5EA),
                        width: 0.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.2 : 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(widget.borderRadius),
                      ),
                      child: ScrollConfiguration(
                        behavior: _NoGlowScrollBehavior(),
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 8,
                          ),
                          shrinkWrap: true,
                          itemCount: widget.items.length,
                          separatorBuilder:
                              (_, __) => Container(
                                height: 1,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                color:
                                    isDark
                                        ? Colors.white.withOpacity(0.08)
                                        : Colors.black.withOpacity(0.06),
                              ),
                          itemBuilder: (context, index) {
                            final item = widget.items[index];
                            final selected = item == widget.selectedItem;

                            return _DropdownItem(
                              item: item,
                              selected: selected,
                              onTap: () {
                                HapticFeedback.selectionClick();
                                widget.onChanged(item);
                                _toggleDropdown();
                              },
                              itemLabel: widget.itemLabel(item),
                              borderRadius: widget.borderRadius,
                              isDark: isDark,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DropdownItem extends StatefulWidget {
  final dynamic item;
  final bool selected;
  final VoidCallback onTap;
  final String itemLabel;
  final double borderRadius;
  final bool isDark;

  const _DropdownItem({
    required this.item,
    required this.selected,
    required this.onTap,
    required this.itemLabel,
    required this.borderRadius,
    required this.isDark,
  });

  @override
  State<_DropdownItem> createState() => _DropdownItemState();
}

class _DropdownItemState extends State<_DropdownItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final textColor =
        widget.selected
            ? const Color(0xFF007AFF)
            : (widget.isDark ? Colors.white : Colors.black);

    final backgroundColor =
        widget.selected
            ? (widget.isDark
                ? const Color(0xFF007AFF).withOpacity(0.15)
                : const Color(0xFF007AFF).withOpacity(0.1))
            : (_isHovered
                ? (widget.isDark
                    ? Colors.white.withOpacity(0.05)
                    : Colors.black.withOpacity(0.03))
                : Colors.transparent);

    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius - 4),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.itemLabel,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight:
                        widget.selected ? FontWeight.w600 : FontWeight.w500,
                    color: textColor,
                    letterSpacing: -0.2,
                    height: 1.2,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (widget.selected) ...[
                const SizedBox(width: 8),
                Icon(
                  CupertinoIcons.checkmark_circle_fill, // Use latest icon
                  // Fallback: Use CupertinoIcons.check_mark_circled_solid if cupertino_icons < 1.0.0
                  size: screenWidth * 0.045,
                  color: const Color(0xFF007AFF),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) => child;
}
