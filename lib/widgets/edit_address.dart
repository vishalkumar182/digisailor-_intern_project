import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:construction_manager_app/widgets/rounded_text_field.dart';
import 'package:construction_manager_app/services/auth/login_service.dart';

class EditAddress extends StatefulWidget {
  final Map<String, String> userData;
  final VoidCallback onSave;

  const EditAddress({super.key, required this.userData, required this.onSave});

  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final LoginService _loginService = LoginService();

  @override
  void initState() {
    super.initState();
    countryController.text = widget.userData['country'] ?? '';
    stateController.text = widget.userData['state'] ?? '';
    cityController.text = widget.userData['city'] ?? '';
  }

  @override
  void dispose() {
    countryController.dispose();
    stateController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void _saveAddress() {
    if (countryController.text.trim().isEmpty ||
        stateController.text.trim().isEmpty ||
        cityController.text.trim().isEmpty) {
      debugPrint('Save address failed: Missing country, state, or city');
      _showErrorDialog('Country, State, and City are required.');
      return;
    }
    _loginService.updateAddress(
      country: countryController.text.trim(),
      state: stateController.text.trim(),
      city: cityController.text.trim(),
    );
    debugPrint(
      'Address saved: ${countryController.text}, ${stateController.text}, ${cityController.text}',
    );
    widget.onSave();
    Navigator.pop(context);
  }

  Future<void> _showErrorDialog(String message) async {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            'Error',
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
            ),
          ),
          content: Padding(
            padding: EdgeInsets.only(top: screenWidth * 0.02),
            child: Text(
              message,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: isDarkMode ? Colors.white70 : const Color(0xFF6B7280),
              ),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF007AFF),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.02,
      ),
      decoration: BoxDecoration(
        color: isDarkMode ? CupertinoColors.black : const Color(0xFFD3E0EA),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Edit Address',
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          RoundedTextField(
            hintText: 'Country',
            icon: CupertinoIcons.globe,
            iconColor: const Color(0xFF5856D6),
            controller: countryController,
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: screenHeight * 0.02),
          RoundedTextField(
            hintText: 'State',
            icon: CupertinoIcons.map_fill,
            iconColor: const Color(0xFF007AFF),
            controller: stateController,
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: screenHeight * 0.02),
          RoundedTextField(
            hintText: 'City',
            icon: CupertinoIcons.location_fill,
            iconColor: const Color(0xFFFF9500),
            controller: cityController,
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: screenHeight * 0.02),
          Center(
            child: CupertinoButton(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenWidth * 0.015,
              ),
              color: const Color(0xFF007AFF),
              borderRadius: BorderRadius.circular(14),
              onPressed: () {
                HapticFeedback.lightImpact();
                _saveAddress();
              },
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
