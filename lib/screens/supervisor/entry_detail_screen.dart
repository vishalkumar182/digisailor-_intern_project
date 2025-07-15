import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:construction_manager_app/screens/supervisor/employee_detail_screen.dart';

class EntryDetailScreen extends StatelessWidget {
  final Map<String, dynamic> entry;

  const EntryDetailScreen({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                        entry['project'],
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
                          'Project Information',
                          [
                            _buildDetail(
                              'Location',
                              entry['location'],
                              CupertinoIcons.location_solid,
                              const Color(0xFF5856D6),
                              isDarkMode,
                              screenWidth,
                            ),
                            _buildDetail(
                              'Date',
                              entry['date'],
                              CupertinoIcons.calendar,
                              const Color(0xFFFF9500),
                              isDarkMode,
                              screenWidth,
                            ),
                            _buildDetail(
                              'Status',
                              entry['status'],
                              CupertinoIcons.checkmark_seal_fill,
                              const Color(0xFF34C759),
                              isDarkMode,
                              screenWidth,
                            ),
                          ],
                          isDarkMode,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        _buildSection(
                          'Timesheet Details',
                          [
                            _buildDetail(
                              'Total Hours',
                              '${entry['hours']} hrs',
                              CupertinoIcons.clock_fill,
                              const Color(0xFF34C759),
                              isDarkMode,
                              screenWidth,
                            ),
                            _buildDetail(
                              'Submitted',
                              entry['timesheet']['submitted'],
                              CupertinoIcons.checkmark_square,
                              const Color(0xFF007AFF),
                              isDarkMode,
                              screenWidth,
                            ),
                          ],
                          isDarkMode,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        _buildSection(
                          'Employees',
                          [
                            ...entry['employeesData']
                                .map<Widget>(
                                  (employee) => _buildEmployeeCard(
                                    employee,
                                    isDarkMode,
                                    screenWidth,
                                    screenHeight,
                                    context,
                                  ),
                                )
                                .toList(),
                          ],
                          isDarkMode,
                          screenWidth,
                        ),
                      ],
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

  Widget _buildEmployeeCard(
    Map<String, dynamic> employee,
    bool isDarkMode,
    double screenWidth,
    double screenHeight,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => EmployeeDetailScreen(
                  employee: employee,
                  entryId: entry['id'],
                ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: screenHeight * 0.02),
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
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: screenWidth * 0.06,
              backgroundColor:
                  isDarkMode
                      ? const Color(0xFF4A4A4C)
                      : const Color(0xFFB0C4DE),
              child: Text(
                employee['name'][0],
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  color: isDarkMode ? Colors.white70 : const Color(0xFF1C2526),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employee['name'],
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w700,
                      color:
                          isDarkMode ? Colors.white : const Color(0xFF1C2526),
                    ),
                  ),
                  Text(
                    employee['role'],
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color:
                          isDarkMode ? Colors.white70 : const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              CupertinoIcons.chevron_right,
              size: screenWidth * 0.05,
              color: isDarkMode ? Colors.white70 : const Color(0xFF007AFF),
            ),
          ],
        ),
      ),
    );
  }
}
