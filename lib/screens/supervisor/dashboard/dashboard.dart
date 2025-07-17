import 'package:construction_manager_app/models/supervisor/dashboard/dashboard.dart';
import 'package:construction_manager_app/screens/supervisor/app_bar/app_bar.dart';
import 'package:construction_manager_app/screens/supervisor/bottom_navigation/bottom_navigation.dart';
import 'package:construction_manager_app/screens/supervisor/card_detail_data.dart/card1_detail.dart';
import 'package:construction_manager_app/screens/supervisor/cusom_card/dashboard_card.dart';
import 'package:construction_manager_app/screens/supervisor/dashboard/dashboard_data.dart';
import 'package:construction_manager_app/screens/supervisor/dashboard/project_detail_page.dart';
import 'package:construction_manager_app/screens/supervisor/entries/supervisor_entries_screen.dart';
import 'package:construction_manager_app/screens/supervisor/quick_action/quick_actions.dart';
import 'package:construction_manager_app/screens/supervisor/timesheet/add_entry.dart';
import 'package:construction_manager_app/screens/supervisor/welcome_card/welcome_card.dart';
import 'package:construction_manager_app/screens/supervisor/profiles/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:construction_manager_app/screens/supervisor/recent_entries.dart';

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
  final String currentProject = DashboardData.currentProject;
  final List<DashboardCard> _dashboardCards = DashboardData.dashboardCards;

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
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Welcome Card Section
          GestureDetector(
            onTap: () => _handleProjectTap(context),
            child: WelcomeCard(
              supervisorName: defaultAppBarData.supervisorName,
              currentProject: currentProject,
            ),
          ),
          SizedBox(height: screenWidth * 0.04), // Uniform spacing
          // Dashboard Cards Row Section
          DashboardCardsRow(
            cards: _dashboardCards,
            onCardTap: (card) => _handleCardTap(context, card),
            height: screenWidth * 0.4, // Default height
          ),
          SizedBox(height: screenWidth * 0.04), // Uniform spacing
          // Recent Entries Section
          const RecentEntries(),
          SizedBox(height: screenWidth * 0.04), // Uniform spacing
          // Quick Actions Section
          QuickActionsSection(
            onActionPressed: _handleQuickAction,
            actions: ['Add Entry'],
            height: screenWidth * 0.15, // Adjusted to match reduced size
          ),
        ],
      ),
    );
  }

  /// Handles dashboard card tap events with proper context
  void _handleCardTap(BuildContext context, DashboardCard card) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DashboardDetailPage(title: card.title),
      ),
    );
  }

  /// Handles project welcome card tap
  void _handleProjectTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProjectDetailPage()),
    );
  }

  /// Handles quick action button presses
  void _handleQuickAction(String action) {
    if (action == 'Add Entry') {
      HapticFeedback.lightImpact();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TimesheetForm(title: 'Add Entry'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Performing $action...'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  /// Builds the sliding notification bar widget
  Widget _buildNotificationBar() {
    final screenWidth = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: _slideAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Container(
            width: screenWidth - 32,
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFFD3E0EA), const Color(0xFFB0C4DE)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFCED4DA)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
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
                    color: const Color(0xFF007AFF).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.campaign,
                    size: 20,
                    color: Color(0xFF007AFF),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Safety Update',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF007AFF),
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
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.grey,
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
                  _handleProfilePressed();
                },
              )
              : null,
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

  /// Handle profile section press
  void _handleProfilePressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SupervisorProfileScreen()),
    );
  }
}
