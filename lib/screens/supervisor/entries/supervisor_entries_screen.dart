import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:construction_manager_app/screens/supervisor/entry_detail_screen.dart';

class SupervisorEntriesScreen extends StatefulWidget {
  const SupervisorEntriesScreen({super.key});

  @override
  State<SupervisorEntriesScreen> createState() =>
      _SupervisorEntriesScreenState();
}

class _SupervisorEntriesScreenState extends State<SupervisorEntriesScreen> {
  String selectedCategory = 'All';

  final List<String> categories = ['All', 'Submitted', 'Draft'];

  final List<Map<String, dynamic>> entries = [
    {
      'id': '1',
      'project': 'Residential Tower',
      'location': 'Delhi',
      'date': '12 July 2025',
      'employees': '18',
      'hours': '144',
      'status': 'Submitted',
      'employeesData': [
        {'id': 'e1', 'name': 'Amit Sharma', 'role': 'Worker'},
        {'id': 'e2', 'name': 'Ravi Kumar', 'role': 'Foreman'},
      ],
      'timesheet': {'totalHours': '144', 'submitted': '12 July 2025'},
    },
    {
      'id': '2',
      'project': 'School Renovation',
      'location': 'Mumbai',
      'date': '11 July 2025',
      'employees': '10',
      'hours': '80',
      'status': 'Draft',
      'employeesData': [
        {'id': 'e3', 'name': 'Priya Menon', 'role': 'Worker'},
      ],
      'timesheet': {'totalHours': '80', 'submitted': '11 July 2025'},
    },
    {
      'id': '3',
      'project': 'Mall Construction',
      'location': 'Lucknow',
      'date': '09 July 2025',
      'employees': '22',
      'hours': '176',
      'status': 'Submitted',
      'employeesData': [
        {'id': 'e4', 'name': 'Suresh Patel', 'role': 'Worker'},
        {'id': 'e5', 'name': 'Vikram Singh', 'role': 'Foreman'},
      ],
      'timesheet': {'totalHours': '176', 'submitted': '09 July 2025'},
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.05;
    final verticalPadding = screenHeight * 0.02;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor:
          isDarkMode ? CupertinoColors.black : const Color(0xFFD3E0EA),
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? CupertinoColors.darkBackgroundGray : Colors.white,
        elevation: 0,
        systemOverlayStyle:
            isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        title: Text(
          'Entries',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: screenWidth * 0.05,
            color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:
                  isDarkMode
                      ? [const Color(0xFF2C2C2E), const Color(0xFF1C1C1E)]
                      : [const Color(0xFFD3E0EA), const Color(0xFFB0C4DE)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildCategorySelector(isDarkMode, screenWidth, screenHeight),
          Expanded(
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                if (selectedCategory != 'All' &&
                    entry['status'] != selectedCategory) {
                  return const SizedBox.shrink();
                }
                return _buildEntryCard(
                  entry,
                  isDarkMode,
                  screenWidth,
                  screenHeight,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySelector(
    bool isDarkMode,
    double screenWidth,
    double screenHeight,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.015,
      ),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1C2526) : const Color(0xFFE8ECEF),
        border: Border.all(
          color:
              isDarkMode
                  ? Colors.white.withOpacity(0.2)
                  : const Color(0xFFCED4DA),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.25 : 0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
            categories.map((category) {
              final isSelected = category == selectedCategory;
              return _CategoryChip(
                category: category,
                isSelected: isSelected,
                onTap: () {
                  HapticFeedback.lightImpact();
                  setState(() => selectedCategory = category);
                },
                isDarkMode: isDarkMode,
                screenWidth: screenWidth,
              );
            }).toList(),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _CategoryChip({
    required String category,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDarkMode,
    required double screenWidth,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenWidth * 0.02,
        ),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? const Color(0xFF007AFF)
                  : (isDarkMode
                      ? const Color(0xFF2C2C2E)
                      : const Color(0xFFECEFF1)),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                isSelected
                    ? const Color(0xFF007AFF)
                    : (isDarkMode
                        ? Colors.white.withOpacity(0.2)
                        : const Color(0xFFCED4DA)),
            width: 1.5,
          ),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: const Color(
                        0xFF007AFF,
                      ).withOpacity(isDarkMode ? 0.3 : 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                      spreadRadius: 1,
                    ),
                  ]
                  : [],
        ),
        child: Text(
          category,
          style: TextStyle(
            color:
                isSelected
                    ? Colors.white
                    : (isDarkMode ? Colors.white70 : const Color(0xFF1C2526)),
            fontWeight: FontWeight.w600,
            fontSize: screenWidth * 0.04,
          ),
        ),
      ),
    );
  }

  Widget _buildEntryCard(
    Map<String, dynamic> entry,
    bool isDarkMode,
    double screenWidth,
    double screenHeight,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EntryDetailScreen(entry: entry),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: screenHeight * 0.02),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1C2526) : const Color(0xFFE8ECEF),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                isDarkMode
                    ? Colors.white.withOpacity(0.2)
                    : const Color(0xFFCED4DA),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDarkMode ? 0.25 : 0.15),
              blurRadius: 10,
              offset: const Offset(0, 3),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry['project'],
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              Row(
                children: [
                  Icon(
                    CupertinoIcons.location_solid,
                    size: screenWidth * 0.045,
                    color:
                        isDarkMode ? Colors.white70 : const Color(0xFF5856D6),
                  ),
                  SizedBox(width: screenWidth * 0.015),
                  Text(
                    entry['location'],
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color:
                          isDarkMode ? Colors.white70 : const Color(0xFF6B7280),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    CupertinoIcons.calendar,
                    size: screenWidth * 0.045,
                    color:
                        isDarkMode ? Colors.white70 : const Color(0xFFFF9500),
                  ),
                  SizedBox(width: screenWidth * 0.015),
                  Text(
                    entry['date'],
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color:
                          isDarkMode ? Colors.white70 : const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.015),
              Row(
                children: [
                  _buildInfoChip(
                    CupertinoIcons.person_2_fill,
                    '${entry['employees']} employees',
                    isDarkMode,
                    screenWidth,
                    const Color(0xFF007AFF),
                  ),
                  SizedBox(width: screenWidth * 0.025),
                  _buildInfoChip(
                    CupertinoIcons.clock_fill,
                    '${entry['hours']} hrs',
                    isDarkMode,
                    screenWidth,
                    const Color(0xFF34C759),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.015),
              Row(
                children: [
                  _buildStatusChip(entry['status'], isDarkMode, screenWidth),
                  const Spacer(),
                  CupertinoButton(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenWidth * 0.015,
                    ),
                    color: const Color(0xFF007AFF),
                    borderRadius: BorderRadius.circular(14),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.eye,
                          size: screenWidth * 0.04,
                          color: Colors.white,
                        ),
                        SizedBox(width: screenWidth * 0.015),
                        Text(
                          'View',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EntryDetailScreen(entry: entry),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(
    IconData icon,
    String text,
    bool isDarkMode,
    double screenWidth,
    Color iconColor,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenWidth * 0.015,
      ),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF2C2C2E) : const Color(0xFFECEFF1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color:
              isDarkMode
                  ? Colors.white.withOpacity(0.2)
                  : const Color(0xFFCED4DA),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: screenWidth * 0.035,
            color: isDarkMode ? Colors.white70 : iconColor,
          ),
          SizedBox(width: screenWidth * 0.015),
          Text(
            text,
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white70 : const Color(0xFF1C2526),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status, bool isDarkMode, double screenWidth) {
    Color chipColor;
    switch (status) {
      case 'Submitted':
        chipColor = const Color(0xFF34C759);
        break;
      case 'Draft':
        chipColor = const Color(0xFFFF9500);
        break;
      default:
        chipColor = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenWidth * 0.015,
      ),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(isDarkMode ? 0.2 : 0.15),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: chipColor.withOpacity(isDarkMode ? 0.4 : 0.3),
          width: 1,
        ),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: isDarkMode ? Colors.white70 : chipColor,
          fontWeight: FontWeight.w600,
          fontSize: screenWidth * 0.035,
        ),
      ),
    );
  }
}
