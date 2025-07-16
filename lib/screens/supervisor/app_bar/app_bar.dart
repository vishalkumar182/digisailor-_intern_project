import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:construction_manager_app/screens/supervisor/profiles/profile_screen.dart'; // For navigation

/// Modern iOS-style app bar for supervisor dashboard with enhanced UX
///
/// This widget provides a custom app bar that follows iOS design principles
/// with smooth animations, haptic feedback, and proper user interaction states.
///
/// Features:
/// - iOS-style color palette and typography
/// - Haptic feedback on interactions
/// - Smooth scale animations
/// - Smart notification badge system
/// - Online/offline status indicators
/// - Proper error handling and fallbacks
class SupervisorAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// The supervisor's display name
  final String supervisorName;

  /// The supervisor's role/title
  final String supervisorRole;

  /// Path to the profile picture asset
  final String profilePicPath;

  /// Whether there are unread notifications
  final bool hasNotifications;

  /// Number of unread notifications (shows badge if > 0)
  final int notificationCount;

  /// Callback when notification button is tapped
  final VoidCallback onNotificationPressed;

  /// Optional callback when profile section is tapped
  final VoidCallback? onProfilePressed;

  /// Height of the app bar (iOS standard is 88pt)
  final double toolbarHeight;

  /// Whether the supervisor is currently online
  final bool isOnline;

  const SupervisorAppBar({
    super.key,
    required this.supervisorName,
    required this.supervisorRole,
    required this.profilePicPath,
    this.hasNotifications = true, // Default to true for unread state
    this.notificationCount = 2, // Default to 2 unread notifications
    required this.onNotificationPressed,
    this.onProfilePressed,
    this.toolbarHeight =
        88.0, // iOS-style larger height for better touch targets
    this.isOnline = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);

  @override
  State<SupervisorAppBar> createState() => _SupervisorAppBarState();
}

/// State class for SupervisorAppBar handling animations and user interactions
class _SupervisorAppBarState extends State<SupervisorAppBar>
    with SingleTickerProviderStateMixin {
  /// Animation controller for smooth scale transitions
  late AnimationController _animationController;

  /// Scale animation for touch feedback
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller with iOS-like timing
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150), // Fast, responsive animation
      vsync: this,
    );

    // Create scale animation that slightly shrinks element when pressed
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95, // Subtle scale down effect
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut, // Smooth easing
      ),
    );
  }

  @override
  void dispose() {
    // Clean up animation controller to prevent memory leaks
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          Colors.transparent, // Let our custom container handle background
      elevation: 0, // Remove default shadow
      scrolledUnderElevation: 0, // Prevent color change when scrolling
      systemOverlayStyle: SystemUiOverlayStyle.dark, // Dark status bar content
      automaticallyImplyLeading: false, // Remove default back button
      flexibleSpace: _buildAppBarContent(),
    );
  }

  /// Builds the main app bar content with iOS-style design
  Widget _buildAppBarContent() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFBFBFD), // iOS-style light background
        border: Border(
          bottom: BorderSide(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.08), // Subtle separator line
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: [
              _buildUserProfile(), // Left side: user profile
              const Spacer(), // Push action buttons to the right
              _buildActionButtons(), // Right side: notifications
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the user profile section with tap animation and navigation
  Widget _buildUserProfile() {
    return GestureDetector(
      // Handle touch down - start press animation
      onTapDown: (_) {
        _animationController.forward();
        HapticFeedback.lightImpact(); // Provide haptic feedback
      },
      // Handle touch up - navigate to profile
      onTapUp: (_) {
        _animationController.reverse();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SupervisorProfileScreen(),
          ),
        );
      },
      // Handle touch cancel - reset animation
      onTapCancel: () {
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Row(
              children: [
                _buildUserAvatar(),
                const SizedBox(width: 14), // iOS-standard spacing
                _buildUserInfo(),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Builds the user avatar with online status indicator
  Widget _buildUserAvatar() {
    return Stack(
      children: [
        // Main avatar container with shadow
        Container(
          width: 44, // iOS-standard touch target size
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2, // Clean white border
            ),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2), // Subtle drop shadow
              ),
            ],
          ),
          child: CircleAvatar(
            backgroundImage: AssetImage(widget.profilePicPath),
            radius: 20,
            backgroundColor: const Color(0xFFF2F2F7), // iOS light gray
            onBackgroundImageError: (exception, stackTrace) {
              // Handle image load error gracefully - could log or show placeholder
            },
            child:
                widget.profilePicPath.isEmpty
                    ? Icon(Icons.person, size: 24, color: Colors.grey.shade600)
                    : null,
          ),
        ),
        // Online status indicator
        Positioned(
          bottom: 2,
          right: 2,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color:
                  widget.isOnline
                      ? const Color(0xFF34C759)
                      : Colors.grey, // iOS green
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the user information section (name and role)
  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Supervisor name
        Text(
          widget.supervisorName,
          style: const TextStyle(
            fontSize: 17, // iOS-standard large text size
            fontWeight: FontWeight.w600, // Semi-bold
            color: Color(0xFF1C1C1E), // iOS dark text
            letterSpacing: -0.4, // Tight letter spacing like iOS
          ),
        ),
        const SizedBox(height: 1), // Minimal spacing
        // Role with online indicator
        Row(
          children: [
            // Small status dot
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: widget.isOnline ? const Color(0xFF34C759) : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            // Role text
            Text(
              widget.supervisorRole,
              style: TextStyle(
                fontSize: 13, // Smaller supporting text
                fontWeight: FontWeight.w400, // Regular weight
                color: const Color(0xFF8E8E93), // iOS secondary text
                letterSpacing: -0.1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Builds the action buttons section (notifications only)
  Widget _buildActionButtons() {
    return Row(children: [_buildNotificationButton()]);
  }

  /// Builds the notification button with badge
  Widget _buildNotificationButton() {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact(); // Provide haptic feedback
            _showNotificationMessage(context);
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              // Highlight background when there are notifications
              color:
                  widget.hasNotifications
                      // ignore: deprecated_member_use
                      ? const Color(0xFF007AFF).withOpacity(
                        0.1,
                      ) // iOS blue tint
                      : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              // Different icon based on notification state
              widget.hasNotifications
                  ? Icons.notifications_active_rounded
                  : Icons.notifications_none_rounded,
              size: 22,
              color:
                  widget.hasNotifications
                      ? const Color(0xFF007AFF) // iOS blue
                      : const Color(0xFF8E8E93), // iOS secondary
            ),
          ),
        ),
        // Notification badge (always show red if notificationCount > 0)
        if (widget.notificationCount > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFFF3B30), // Permanent red badge
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 1),
              ),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: Text(
                // Show 99+ for large numbers
                widget.notificationCount > 99
                    ? '99+'
                    : '${widget.notificationCount}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  height: 1.0, // Tight line height
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  /// Shows a notification message at the top using AlertDialog
  void _showNotificationMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notifications'),
          content: Text('Notifications: ${widget.notificationCount} unread'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          backgroundColor: const Color(0xFFF2F2F7), // iOS light background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        );
      },
    );
  }
}

/// Enhanced app bar data model with additional properties
///
/// This model contains all the necessary information to display
/// a supervisor's profile in the app bar with proper state management.
class AppBarData {
  /// The supervisor's full name
  final String supervisorName;

  /// The supervisor's job title or role
  final String supervisorRole;

  /// Asset path to the supervisor's profile picture
  final String profilePicPath;

  /// Whether the supervisor is currently online/active
  final bool isOnline;

  /// Number of unread notifications
  final int notificationCount;

  const AppBarData({
    required this.supervisorName,
    required this.supervisorRole,
    required this.profilePicPath,
    this.isOnline = true,
    this.notificationCount = 2, // Default to 2 unread notifications
  });
}

/// Default app bar data with realistic values for testing
///
/// This provides sensible defaults that can be used during development
/// or as fallback values when real data is not available.
const defaultAppBarData = AppBarData(
  supervisorName: 'Vishal Kumar',
  supervisorRole: 'Senior Site Supervisor',
  profilePicPath: 'assets/icons/profile.png',
  isOnline: true,
  notificationCount: 2, // Default to show 2 unread notifications
);

/// Example usage widget demonstrating how to implement the SupervisorAppBar
///
/// This shows proper state management and callback handling for a real-world
/// implementation of the app bar in a supervisor dashboard.
class SupervisorDashboard extends StatefulWidget {
  const SupervisorDashboard({super.key});

  @override
  State<SupervisorDashboard> createState() => _SupervisorDashboardState();
}

/// State management for the supervisor dashboard
class _SupervisorDashboardState extends State<SupervisorDashboard> {
  // Track notification state
  final bool _hasNotifications = true; // Default to true for unread state
  final int _notificationCount = 2; // Default to 2 unread notifications

  /// Handle notification button press
  /// This shows a message without clearing the badge
  void _handleNotificationPressed() {
    _showNotificationMessage(context);
  }

  /// Handle profile section press
  /// This navigates to the profile screen
  void _handleProfilePressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SupervisorProfileScreen()),
    );
  }

  /// Shows a temporary notification message on tap (placeholder, moved to app bar)
  void _showNotificationMessage(BuildContext context) {
    // This is now handled in _SupervisorAppBarState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // iOS-style background color
      backgroundColor: const Color(0xFFF2F2F7),

      // Our custom app bar
      appBar: SupervisorAppBar(
        supervisorName: defaultAppBarData.supervisorName,
        supervisorRole: defaultAppBarData.supervisorRole,
        profilePicPath: defaultAppBarData.profilePicPath,
        hasNotifications: _hasNotifications,
        notificationCount: _notificationCount,
        isOnline: defaultAppBarData.isOnline,
        onNotificationPressed: _handleNotificationPressed,
        onProfilePressed: _handleProfilePressed,
      ),

      // Dashboard content
      body: const Center(
        child: Text(
          'Dashboard Content',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1C1C1E), // iOS dark text
          ),
        ),
      ),
    );
  }
}
