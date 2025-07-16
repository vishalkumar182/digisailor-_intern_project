import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:construction_manager_app/widgets/rounded_text_field.dart';
import 'package:construction_manager_app/services/auth/login_service.dart';

class EditPersonalDetails extends StatefulWidget {
  final Map<String, String> userData;
  final VoidCallback onSave;

  const EditPersonalDetails({
    super.key,
    required this.userData,
    required this.onSave,
  });

  @override
  // ignore: library_private_types_in_public_api
  _EditPersonalDetailsState createState() => _EditPersonalDetailsState();
}

class _EditPersonalDetailsState extends State<EditPersonalDetails> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final LoginService _loginService = LoginService();
  final ImagePicker _picker = ImagePicker();
  DateTime? selectedDate;
  XFile? selectedImage;

  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.userData['firstName'] ?? '';
    lastNameController.text = widget.userData['lastName'] ?? '';
    positionController.text = widget.userData['position'] ?? '';
    selectedDate =
        DateTime.tryParse(widget.userData['dob'] ?? '') ?? DateTime(1990, 1, 1);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    positionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFF007AFF),
              onPrimary: Colors.white,
              surface: const Color(0xFFE8ECEF),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      debugPrint('Selected date: ${picked.toIso8601String()}');
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          selectedImage = image;
        });
        debugPrint('Image picked: ${image.path}');
      }
    } catch (e) {
      debugPrint('Image picker error: $e');
      _showErrorDialog('Failed to pick image: $e');
    }
  }

  void _saveDetails() {
    if (firstNameController.text.trim().isEmpty ||
        positionController.text.trim().isEmpty) {
      debugPrint('Save details failed: Missing first name or position');
      _showErrorDialog('First Name and Position are required.');
      return;
    }
    _loginService.updatePersonalDetails(
      firstName: firstNameController.text.trim(),
      lastName:
          lastNameController.text.trim().isEmpty
              ? null
              : lastNameController.text.trim(),
      dob: selectedDate!.toIso8601String().split('T').first,
      position: positionController.text.trim(),
      photo: selectedImage?.path,
    );
    debugPrint(
      'Details saved: ${firstNameController.text}, ${positionController.text}, ${selectedDate!.toIso8601String()}',
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
            'Edit Personal Details',
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: screenWidth * 0.1,
                  backgroundImage:
                      selectedImage != null
                          ? FileImage(File(selectedImage!.path))
                          : const AssetImage('assets/images/user.png')
                              as ImageProvider,
                  backgroundColor:
                      isDarkMode
                          ? const Color(0xFF3C3C3E)
                          : const Color(0xFFECEFF1),
                ),
                GestureDetector(
                  onTap: _pickImage,
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
          ),
          SizedBox(height: screenHeight * 0.02),
          RoundedTextField(
            hintText: 'First Name',
            icon: CupertinoIcons.person_fill,
            iconColor: const Color(0xFF007AFF),
            controller: firstNameController,
            keyboardType: TextInputType.name,
          ),
          SizedBox(height: screenHeight * 0.02),
          RoundedTextField(
            hintText: 'Last Name (Optional)',
            icon: CupertinoIcons.person_fill,
            iconColor: const Color(0xFF007AFF),
            controller: lastNameController,
            keyboardType: TextInputType.name,
          ),
          SizedBox(height: screenHeight * 0.02),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenWidth * 0.04,
              ),
              decoration: BoxDecoration(
                color:
                    isDarkMode
                        ? const Color(0xFF1C2526)
                        : const Color(0xFFE8ECEF),
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
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.calendar,
                    size: screenWidth * 0.05,
                    color:
                        isDarkMode ? Colors.white70 : const Color(0xFF34C759),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Text(
                    selectedDate != null
                        ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                        : 'Select Date of Birth',
                    style: TextStyle(
                      fontSize: screenWidth * 0.042,
                      fontWeight: FontWeight.w600,
                      color:
                          isDarkMode ? Colors.white : const Color(0xFF1C2526),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          RoundedTextField(
            hintText: 'Position',
            icon: CupertinoIcons.briefcase_fill,
            iconColor: const Color(0xFFFF9500),
            controller: positionController,
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
                _saveDetails();
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
