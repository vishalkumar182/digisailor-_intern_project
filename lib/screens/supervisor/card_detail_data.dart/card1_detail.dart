import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class DashboardDetailPage extends StatefulWidget {
  final String title;

  const DashboardDetailPage({super.key, required this.title});

  @override
  State<DashboardDetailPage> createState() => _DashboardDetailPageState();
}

class _DashboardDetailPageState extends State<DashboardDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1C1C1E),
            letterSpacing: -0.4,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        shadowColor: Colors.black.withOpacity(0.1),
      ),
      backgroundColor: const Color(0xFFF2F2F7),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    _getIcon(widget.title),
                    size: 36,
                    color: _getColor(widget.title),
                  ),
                  Text(
                    _getStatusText(widget.title),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _getColor(widget.title),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _buildOverviewCard(),
              const SizedBox(height: 12),
              _buildWorkerCard(),
              const SizedBox(height: 12),
              _buildPerformanceCard(),
              const SizedBox(height: 12),
              _buildMilestoneCard(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- Cards ---------- //

  Widget _buildOverviewCard() {
    return _cardContainer(
      title: 'Overview',
      child: Column(
        children: [
          _buildStatRow(Icons.people, 'Total', '150'),
          _buildStatRow(Icons.check_circle, 'Active', '100'),
          _buildStatRow(Icons.trending_up, 'Target', '200'),
        ],
      ),
    );
  }

  Widget _buildWorkerCard() {
    return _cardContainer(
      title: 'Worker Highlights',
      child: Column(
        children: [
          _buildWorkerRow(Icons.person, 'John Doe', 'Present', 'Jul 15, 2025'),
          _buildWorkerRow(
            Icons.person_outline,
            'Jane Smith',
            'Working',
            'Jul 14, 2025',
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceCard() {
    return _cardContainer(
      title: 'Performance & Trends',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            value: 0.75,
            backgroundColor: const Color(0xFFE5E5EA),
            color: _getColor(widget.title),
            minHeight: 4,
          ),
          const SizedBox(height: 6),
          Text('Progress: 75%', style: _textStyle(10, FontWeight.w500)),
          const SizedBox(height: 4),
          _buildDetailRow(Icons.access_time, 'Updated: Today, 05:30 PM'),
        ],
      ),
    );
  }

  Widget _buildMilestoneCard() {
    return _cardContainer(
      title: 'Milestones',
      child: Column(
        children: [
          _buildDetailRow(Icons.flag, 'Foundation Completed'),
          _buildDetailRow(Icons.flag, 'Structure 70% Complete'),
          _buildDetailRow(Icons.flag, 'Electrical Work Started'),
        ],
      ),
    );
  }

  // ---------- Components ---------- //

  Widget _cardContainer({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _textStyle(13, FontWeight.w600)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _buildStatRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: const Color(0xFF007AFF)),
              const SizedBox(width: 6),
              Text(
                label,
                style: _textStyle(
                  10,
                  FontWeight.w400,
                  color: const Color(0xFF8E8E93),
                ),
              ),
            ],
          ),
          Text(value, style: _textStyle(12, FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildWorkerRow(
    IconData icon,
    String name,
    String status,
    String date,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: _getStatusColor(status),
            child: Icon(icon, size: 14, color: Colors.white),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: _textStyle(11, FontWeight.w500)),
                const SizedBox(height: 2),
                Text(
                  'Status: $status | Date: $date',
                  style: _textStyle(
                    9,
                    FontWeight.w400,
                    color: const Color(0xFF8E8E93),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(icon, size: 12, color: const Color(0xFF007AFF)),
          const SizedBox(width: 5),
          Expanded(child: Text(text, style: _textStyle(10, FontWeight.w500))),
        ],
      ),
    );
  }

  TextStyle _textStyle(
    double size,
    FontWeight weight, {
    Color color = const Color(0xFF1C1C1E),
  }) {
    return TextStyle(fontSize: size, fontWeight: weight, color: color);
  }

  // ---------- Helpers ---------- //

  IconData _getIcon(String title) {
    switch (title) {
      case 'Total Employees':
        return Icons.people;
      case 'Checked In':
        return Icons.check_circle;
      case 'Checked Out':
        return Icons.cancel;
      case 'Total Hours':
        return Icons.access_time;
      case 'Project':
        return Icons.engineering;
      default:
        return Icons.error;
    }
  }

  Color _getColor(String title) {
    switch (title) {
      case 'Total Employees':
        return const Color(0xFF007AFF);
      case 'Checked In':
        return const Color(0xFF34C759);
      case 'Checked Out':
        return const Color(0xFFFF3B30);
      case 'Total Hours':
        return const Color(0xFFFF9500);
      case 'Project':
        return const Color(0xFF5856D6);
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String title) {
    switch (title) {
      case 'Total Employees':
        return 'Workforce Snapshot';
      case 'Checked In':
        return 'On Site Now';
      case 'Checked Out':
        return 'Off Site Today';
      case 'Total Hours':
        return 'Work Insights';
      case 'Project':
        return 'Project Status';
      default:
        return 'Status';
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'present':
      case 'working':
        return const Color(0xFF34C759);
      case 'on break':
        return const Color(0xFFFF9500);
      case 'off duty':
        return const Color(0xFFFF3B30);
      default:
        return Colors.grey;
    }
  }
}
