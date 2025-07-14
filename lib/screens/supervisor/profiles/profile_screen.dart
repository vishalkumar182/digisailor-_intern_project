import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SupervisorProfileScreen extends StatelessWidget {
  const SupervisorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 24),
          _buildSectionTitle('Account'),
          _buildOptionTile(Icons.person, 'Supervisor Name', 'Vishal Kumar'),
          _buildOptionTile(Icons.badge, 'Supervisor ID', 'SVP-1001'),
          const SizedBox(height: 24),
          _buildSectionTitle('Contact'),
          _buildOptionTile(Icons.phone, 'Phone Number', '+91 9876543210'),
          _buildOptionTile(Icons.email, 'Email', 'vishal@gmail.com'),
          const SizedBox(height: 24),
          _buildSectionTitle('Settings'),
          _buildSimpleOption(Icons.lock, 'Change Password'),
          _buildSimpleOption(Icons.settings, 'App Settings'),
          _buildSimpleOption(Icons.help_outline, 'Help & Support'),
          const SizedBox(height: 40),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  /// Profile header with image and name
  Widget _buildProfileHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundImage: AssetImage('assets/images/user.png'),
        ),
        const SizedBox(height: 12),
        const Text(
          'Vishal Kumar',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Supervisor',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  /// Section title widget
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  /// Account or Contact tile with icon and value
  Widget _buildOptionTile(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        trailing: Text(
          value,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
        ),
      ),
    );
  }

  /// Simple settings tile without value
  Widget _buildSimpleOption(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(CupertinoIcons.chevron_forward, size: 20),
        onTap: () {
          // TODO: Add functionality later
        },
      ),
    );
  }

  /// Logout button design
  Widget _buildLogoutButton(BuildContext context) {
    return CupertinoButton(
      color: Colors.redAccent,
      padding: const EdgeInsets.symmetric(vertical: 16),
      borderRadius: BorderRadius.circular(14),
      child: const Text(
        'Logout',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      onPressed: () {
        // TODO: Add logout logic later
      },
    );
  }
}
