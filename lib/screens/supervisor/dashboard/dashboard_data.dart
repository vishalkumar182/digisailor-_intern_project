// lib/screens/supervisor/dashboard_data.dart
import 'package:construction_manager_app/models/supervisor/dashboard_model/dashboard.dart';
import 'package:flutter/material.dart';

/// Contains all static data used in the dashboard
class DashboardData {
  /// Current project information
  static const String currentProject = 'Tower Construction Phase II';

  /// Dashboard cards configuration
  static final List<DashboardCard> dashboardCards = [
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
}
