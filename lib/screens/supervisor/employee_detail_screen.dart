import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:construction_manager_app/screens/supervisor/employee_edit_screen.dart';
import 'package:flutter/services.dart';

class EmployeeDetailScreen extends StatelessWidget {
  final Map<String, dynamic> employee;
  final String entryId;

  const EmployeeDetailScreen({
    super.key,
    required this.employee,
    required this.entryId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final List<Map<String, String>> workHistory = [
      {'date': '10 July 2025', 'task': 'Foundation Work', 'hours': '8'},
      {'date': '11 July 2025', 'task': 'Wall Construction', 'hours': '7'},
    ];

    return Scaffold(
      body: Container(
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
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        CupertinoIcons.chevron_left,
                        color:
                            isDarkMode
                                ? Colors.white70
                                : const Color(0xFF007AFF),
                        size: screenWidth * 0.06,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        employee['name'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w800,
                          color:
                              isDarkMode
                                  ? Colors.white
                                  : const Color(0xFF1C2526),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors:
                          isDarkMode
                              ? [
                                const Color(0xFF3A3A3C),
                                const Color(0xFF2C2C2E),
                              ]
                              : [
                                const Color(0xFFE8ECEF),
                                const Color(0xFFD3E0EA),
                              ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.2),
                        blurRadius: 15,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSection(
                          'Employee Details',
                          [
                            _buildDetail(
                              'Name',
                              employee['name'],
                              CupertinoIcons.person_fill,
                              const Color(0xFF007AFF),
                              isDarkMode,
                              screenWidth,
                            ),
                            _buildDetail(
                              'Role',
                              employee['role'],
                              CupertinoIcons.briefcase_fill,
                              const Color(0xFFFF9500),
                              isDarkMode,
                              screenWidth,
                            ),
                            _buildDetail(
                              'Entry ID',
                              entryId,
                              CupertinoIcons.number,
                              const Color(0xFF5856D6),
                              isDarkMode,
                              screenWidth,
                            ),
                          ],
                          isDarkMode,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        _buildSection(
                          'Work History',
                          [
                            ...workHistory.map<Widget>(
                              (history) => _buildWorkHistoryItem(
                                history,
                                isDarkMode,
                                screenWidth,
                              ),
                            ),
                          ],
                          isDarkMode,
                          screenWidth,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors:
                        isDarkMode
                            ? [const Color(0xFF2C2C2E), const Color(0xFF1C1C1E)]
                            : [
                              const Color(0xFFD3E0EA),
                              const Color(0xFFB0C4DE),
                            ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CupertinoButton(
                        color: const Color(0xFFFF2D55),
                        borderRadius: BorderRadius.circular(14),
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      EmployeeEditScreen(employee: employee),
                            ),
                          );
                        },
                        child: Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    String title,
    List<Widget> children,
    bool isDarkMode,
    double screenWidth,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        ...children,
      ],
    );
  }

  Widget _buildDetail(
    String label,
    String value,
    IconData icon,
    Color iconColor,
    bool isDarkMode,
    double screenWidth,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.02),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(screenWidth * 0.015),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: screenWidth * 0.04, color: iconColor),
          ),
          SizedBox(width: screenWidth * 0.02),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color:
                        isDarkMode ? Colors.white70 : const Color(0xFF6B7280),
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkHistoryItem(
    Map<String, String> history,
    bool isDarkMode,
    double screenWidth,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.02),
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.03),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:
                isDarkMode
                    ? [const Color(0xFF3A3A3C), const Color(0xFF2C2C2E)]
                    : [const Color(0xFFF7F9FC), const Color(0xFFE8ECEF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              CupertinoIcons.clock,
              size: screenWidth * 0.04,
              color: isDarkMode ? Colors.white70 : const Color(0xFF34C759),
            ),
            SizedBox(width: screenWidth * 0.02),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    history['date']!,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color:
                          isDarkMode ? Colors.white70 : const Color(0xFF6B7280),
                    ),
                  ),
                  Text(
                    history['task']!,
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                      color:
                          isDarkMode ? Colors.white : const Color(0xFF1C2526),
                    ),
                  ),
                  Text(
                    '${history['hours']} hrs',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color:
                          isDarkMode ? Colors.white70 : const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
