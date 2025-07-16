import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:construction_manager_app/widgets/custom_logout_button.dart';
import 'package:construction_manager_app/widgets/edit_personal_details.dart';
import 'package:construction_manager_app/widgets/edit_address.dart';
import 'package:construction_manager_app/services/auth/login_service.dart';

class SupervisorProfileScreen extends StatefulWidget {
  const SupervisorProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SupervisorProfileScreenState createState() =>
      _SupervisorProfileScreenState();
}

class _SupervisorProfileScreenState extends State<SupervisorProfileScreen> {
  final LoginService _loginService = LoginService();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.05;
    final verticalPadding = screenHeight * 0.02;
    final userData = _loginService.getDummyUser();

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
          'Profile',
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
      body: ListView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        children: [
          _buildProfileHeader(isDarkMode, screenWidth, screenHeight, userData),
          SizedBox(height: verticalPadding),
          _buildSectionTitle('Personal Details', isDarkMode, screenWidth),
          _buildEditableOptionTile(
            CupertinoIcons.person_fill,
            'Name',
            '${userData['firstName'] ?? 'Vishal'} ${userData['lastName'] ?? ''}'
                .trim(),
            isDarkMode,
            screenWidth,
            const Color(0xFF5856D6),
            () => _showEditPersonalDetails(context, userData),
          ),
          _buildOptionTile(
            CupertinoIcons.calendar,
            'Date of Birth',
            userData['dob'] ?? '1990-01-01',
            isDarkMode,
            screenWidth,
            const Color(0xFF34C759),
          ),
          _buildOptionTile(
            CupertinoIcons.briefcase_fill,
            'Position',
            userData['position'] ?? 'Supervisor',
            isDarkMode,
            screenWidth,
            const Color(0xFFFF9500),
          ),
          SizedBox(height: verticalPadding),
          _buildSectionTitle('Address', isDarkMode, screenWidth),
          _buildEditableOptionTile(
            CupertinoIcons.globe,
            'Country',
            userData['country'] ?? 'India',
            isDarkMode,
            screenWidth,
            const Color(0xFF5856D6),
            () => _showEditAddress(context, userData),
          ),
          _buildOptionTile(
            CupertinoIcons.map_fill,
            'State',
            userData['state'] ?? 'Jharkhand',
            isDarkMode,
            screenWidth,
            const Color(0xFF007AFF),
          ),
          _buildOptionTile(
            CupertinoIcons.location_fill,
            'City',
            userData['city'] ?? 'Dumka',
            isDarkMode,
            screenWidth,
            const Color(0xFFFF9500),
          ),
          SizedBox(height: verticalPadding),
          _buildSectionTitle('Account', isDarkMode, screenWidth),
          _buildOptionTile(
            CupertinoIcons.person_fill,
            'Supervisor Name',
            userData['name'] ?? 'Vishal Kumar',
            isDarkMode,
            screenWidth,
            const Color(0xFF5856D6),
          ),
          _buildOptionTile(
            CupertinoIcons.tag_fill,
            'Supervisor ID',
            userData['id'] ?? 'SVP-1001',
            isDarkMode,
            screenWidth,
            const Color(0xFFFF9500),
          ),
          SizedBox(height: verticalPadding),
          _buildSectionTitle('Contact', isDarkMode, screenWidth),
          _buildOptionTile(
            CupertinoIcons.phone_fill,
            'Phone Number',
            '+91 9876543210',
            isDarkMode,
            screenWidth,
            const Color(0xFF007AFF),
          ),
          _buildOptionTile(
            CupertinoIcons.envelope_fill,
            'Email',
            userData['email'] ?? 'vishal@gmail.com',
            isDarkMode,
            screenWidth,
            const Color(0xFF34C759),
          ),
          SizedBox(height: verticalPadding),
          _buildSectionTitle('Settings', isDarkMode, screenWidth),
          _buildSimpleOption(
            CupertinoIcons.lock_fill,
            'Change Password',
            isDarkMode,
            screenWidth,
            const Color(0xFF5856D6),
          ),
          _buildSimpleOption(
            CupertinoIcons.gear_alt_fill,
            'App Settings',
            isDarkMode,
            screenWidth,
            const Color(0xFFFF9500),
          ),
          _buildSimpleOption(
            CupertinoIcons.question_circle_fill,
            'Help & Support',
            isDarkMode,
            screenWidth,
            const Color(0xFF007AFF),
          ),
          SizedBox(height: verticalPadding * 2),
          CustomLogoutButton(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(
    bool isDarkMode,
    double screenWidth,
    double screenHeight,
    Map<String, String> userData,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors:
              isDarkMode
                  ? [const Color(0xFF2C2C2E), const Color(0xFF1C2526)]
                  : [const Color(0xFFE8ECEF), const Color(0xFFDDE4E8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.15),
            blurRadius: 14,
            offset: const Offset(0, 4),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: screenWidth * 0.15,
                backgroundImage:
                    userData['photo']?.isNotEmpty == true
                        ? FileImage(File(userData['photo']!))
                        : const AssetImage('assets/icons/profile.png')
                            as ImageProvider,
                backgroundColor:
                    isDarkMode
                        ? const Color(0xFF3C3C3E)
                        : const Color(0xFFECEFF1),
              ),
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  _showEditPersonalDetails(context, userData);
                },
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.015),
                  decoration: BoxDecoration(
                    color: const Color(0xFF007AFF),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    CupertinoIcons.camera_fill,
                    size: screenWidth * 0.04,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.015),
          Text(
            userData['name'] ?? 'Vishal Kumar',
            style: TextStyle(
              fontSize: screenWidth * 0.055,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          Text(
            userData['position'] ?? 'Supervisor',
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white70 : const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDarkMode, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.02),
      child: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth * 0.05,
          fontWeight: FontWeight.w700,
          color: isDarkMode ? Colors.white : const Color(0xFF007AFF),
        ),
      ),
    );
  }

  Widget _buildOptionTile(
    IconData icon,
    String title,
    String value,
    bool isDarkMode,
    double screenWidth,
    Color iconColor,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: screenWidth * 0.025),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1C2526) : const Color(0xFFE8ECEF),
        borderRadius: BorderRadius.circular(14),
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
      child: ListTile(
        leading: Icon(
          icon,
          color: isDarkMode ? Colors.white70 : iconColor,
          size: screenWidth * 0.06,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: screenWidth * 0.042,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
          ),
        ),
        trailing: Text(
          value,
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.white70 : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  Widget _buildEditableOptionTile(
    IconData icon,
    String title,
    String value,
    bool isDarkMode,
    double screenWidth,
    Color iconColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: screenWidth * 0.025),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1C2526) : const Color(0xFFE8ECEF),
          borderRadius: BorderRadius.circular(14),
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
        child: ListTile(
          leading: Icon(
            icon,
            color: isDarkMode ? Colors.white70 : iconColor,
            size: screenWidth * 0.06,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.042,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.white70 : const Color(0xFF6B7280),
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              Icon(
                CupertinoIcons.pencil_circle_fill,
                size: screenWidth * 0.05,
                color: isDarkMode ? Colors.white70 : const Color(0xFF007AFF),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSimpleOption(
    IconData icon,
    String title,
    bool isDarkMode,
    double screenWidth,
    Color iconColor,
  ) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        //
      },
      child: Container(
        margin: EdgeInsets.only(bottom: screenWidth * 0.025),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1C2526) : const Color(0xFFE8ECEF),
          borderRadius: BorderRadius.circular(14),
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
        child: ListTile(
          leading: Icon(
            icon,
            color: isDarkMode ? Colors.white70 : iconColor,
            size: screenWidth * 0.06,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.042,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
            ),
          ),
          trailing: Icon(
            CupertinoIcons.chevron_forward,
            size: screenWidth * 0.05,
            color: isDarkMode ? Colors.white70 : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  void _showEditPersonalDetails(
    BuildContext context,
    Map<String, String> userData,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: 0.65,
            minChildSize: 0.4,
            maxChildSize: 0.85,
            builder:
                (context, scrollController) => EditPersonalDetails(
                  userData: userData,
                  onSave: () => setState(() {}),
                ),
          ),
    );
  }

  void _showEditAddress(BuildContext context, Map<String, String> userData) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.4,
            maxChildSize: 0.7,
            builder:
                (context, scrollController) => EditAddress(
                  userData: userData,
                  onSave: () => setState(() {}),
                ),
          ),
    );
  }
}
