import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeEditScreen extends StatefulWidget {
  final Map<String, dynamic> employee;

  const EmployeeEditScreen({super.key, required this.employee});

  @override
  State<EmployeeEditScreen> createState() => _EmployeeEditScreenState();
}

class _EmployeeEditScreenState extends State<EmployeeEditScreen> {
  late TextEditingController nameController;
  late TextEditingController roleController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.employee['name']);
    roleController = TextEditingController(text: widget.employee['role']);
  }

  @override
  void dispose() {
    nameController.dispose();
    roleController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    setState(() {
      widget.employee['name'] = nameController.text.trim();
      widget.employee['role'] = roleController.text.trim();
    });
    Navigator.pop(context);
  }

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
                        'Edit Employee',
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
                        _buildInputField(
                          'Name',
                          nameController,
                          CupertinoIcons.person_fill,
                          const Color(0xFF007AFF),
                          isDarkMode,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        _buildInputField(
                          'Role',
                          roleController,
                          CupertinoIcons.briefcase_fill,
                          const Color(0xFFFF9500),
                          isDarkMode,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        Center(
                          child: CupertinoButton(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.08,
                              vertical: screenWidth * 0.02,
                            ),
                            color: const Color(0xFF007AFF),
                            borderRadius: BorderRadius.circular(16),
                            onPressed: _saveChanges,
                            child: Text(
                              'Save Changes',
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller,
    IconData icon,
    Color iconColor,
    bool isDarkMode,
    double screenWidth,
  ) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              isDarkMode
                  ? [const Color(0xFF4A4A4C), const Color(0xFF3A3A3C)]
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
          Container(
            padding: EdgeInsets.all(screenWidth * 0.015),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.25),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: screenWidth * 0.04, color: iconColor),
          ),
          SizedBox(width: screenWidth * 0.02),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: label,
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: isDarkMode ? Colors.white70 : const Color(0xFF6B7280),
                ),
              ),
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
