import 'package:construction_manager_app/models/supervisor/dashboard/dashboard.dart';
import 'package:construction_manager_app/screens/supervisor/app_bar/app_bar.dart';
import 'package:construction_manager_app/screens/supervisor/bottom_navigation/bottom_navigation.dart';
import 'package:construction_manager_app/screens/supervisor/cusom_card/dashboard_card.dart';
import 'package:construction_manager_app/screens/supervisor/entries/supervisor_entries_screen.dart';
import 'package:construction_manager_app/screens/supervisor/quick_action/quick_actions.dart';
import 'package:construction_manager_app/screens/supervisor/welcome_card/welcome_card.dart';
import 'package:construction_manager_app/screens/supervisor/profiles/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Main dashboard screen for supervisors with navigation and key functionality
class SupervisorDashboardScreen extends StatefulWidget {
  const SupervisorDashboardScreen({super.key});

  @override
  State<SupervisorDashboardScreen> createState() =>
      _SupervisorDashboardScreenState();
}

class _SupervisorDashboardScreenState extends State<SupervisorDashboardScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  bool _showNotificationBar = false;
  late AnimationController _notificationController;
  late AnimationController _fadeController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  // Current project information
  static const String currentProject = 'Tower Construction Phase II';

  /// Dashboard cards configuration
  final List<DashboardCard> _dashboardCards = [
    DashboardCard(
      title: 'Total Employees',
      value: '12',
      subtitle: '3 pending',
      icon: Icons.task_alt,
      color: Colors.blue,
      trend: '+2 from yesterday',
    ),
    DashboardCard(
      title: 'Checked in',
      value: '24',
      subtitle: 'On site now',
      icon: Icons.people,
      color: Colors.green,
      trend: '2 on break',
    ),
    DashboardCard(
      title: 'Checked out',
      value: '0',
      subtitle: 'All clear',
      icon: Icons.security,
      color: Colors.orange,
      trend: 'Last: 2 days ago',
    ),
    DashboardCard(
      title: 'Total hours',
      value: '78%',
      subtitle: 'This week',
      icon: Icons.trending_up,
      color: Colors.purple,
      trend: '+12% from last week',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _fadeController.forward();
  }

  /// Initializes all animation controllers and animations
  void _initializeAnimations() {
    _notificationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: -100.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _notificationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _notificationController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  /// Handles bottom navigation tab changes
  void _onTabTapped(int index) {
    if (index != _currentIndex) {
      HapticFeedback.lightImpact();
      setState(() => _currentIndex = index);
    }
  }

  /// Toggles the notification bar visibility
  void _toggleNotificationBar() {
    setState(() => _showNotificationBar = !_showNotificationBar);
    _showNotificationBar
        ? _notificationController.forward()
        : _notificationController.reverse();
  }

  /// Builds the appropriate content based on current tab index
  Widget _buildMainContent() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return const SupervisorEntriesScreen();
      case 2:
        return const SupervisorProfileScreen();
      default:
        return _buildHomeContent();
    }
  }

  /// Builds the home tab content with dashboard widgets
  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          WelcomeCard(
            supervisorName: defaultAppBarData.supervisorName,
            currentProject: currentProject,
          ),
          DashboardCardsRow(cards: _dashboardCards, onCardTap: _handleCardTap),
          const SizedBox(height: 20),
          QuickActionsSection(onActionPressed: _handleQuickAction),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  /// Handles dashboard card tap events
  void _handleCardTap(DashboardCard card) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening ${card.title} details...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Handles quick action button presses
  void _handleQuickAction(String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Performing $action...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Builds the sliding notification bar widget
  Widget _buildNotificationBar() {
    return AnimatedBuilder(
      animation: _slideAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade50, Colors.blue.shade100],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blue.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.campaign,
                    size: 20,
                    color: Colors.blue.shade700,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Safety Update',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'New safety regulations are now in effect. Please review the updated guidelines.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _toggleNotificationBar,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar:
          _currentIndex == 0
              ? SupervisorAppBar(
                supervisorName: defaultAppBarData.supervisorName,
                supervisorRole: defaultAppBarData.supervisorRole,
                profilePicPath: defaultAppBarData.profilePicPath,
                hasNotifications: _showNotificationBar,
                notificationCount: defaultAppBarData.notificationCount,
                isOnline: defaultAppBarData.isOnline,
                onNotificationPressed: _toggleNotificationBar,
                onProfilePressed: () {
                  // Profile tap action - optional
                  print('Profile tapped');
                },
              )
              : null, // No AppBar for other tabs
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            if (_showNotificationBar) _buildNotificationBar(),
            Expanded(child: _buildMainContent()),
          ],
        ),
      ),
      bottomNavigationBar: SupervisorBottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          bottomNavItem(
            iconPath: 'assets/icons/home.svg',
            label: 'Home',
            isActive: _currentIndex == 0,
          ),
          bottomNavItem(
            iconPath: 'assets/icons/entries.svg',
            label: 'Entries',
            isActive: _currentIndex == 1,
          ),
          bottomNavItem(
            iconPath: 'assets/icons/user.svg',
            label: 'Profile',
            isActive: _currentIndex == 2,
          ),
        ],
      ),
    );
  }
}
