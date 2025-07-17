import 'package:construction_manager_app/widgets/custom_dropdown.dart';
import 'package:construction_manager_app/widgets/custom_submmit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'timesheet_dummy_data.dart';

class TimesheetForm extends StatefulWidget {
  final String title;

  const TimesheetForm({super.key, required this.title});

  @override
  State<TimesheetForm> createState() => _TimesheetFormState();
}

class _TimesheetFormState extends State<TimesheetForm> {
  String? _selectedLocation;
  String? _selectedProject;
  String? _selectedProjectCode;
  String? _selectedEmployee;

  final _remarksController = TextEditingController();
  final _remarksFocusNode = FocusNode();

  // Time variables
  TimeOfDay? _signInTime;
  TimeOfDay? _breakStartTime;
  TimeOfDay? _breakEndTime;
  TimeOfDay? _signOutTime;
  TimeOfDay? _travelStartTime;
  TimeOfDay? _travelEndTime;

  @override
  void initState() {
    super.initState();
    _remarksFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.05;
    final verticalPadding = screenHeight * 0.025;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor:
          isDarkMode ? CupertinoColors.black : const Color(0xFFD3E0EA),
      appBar: AppBar(
        title: Text(
          widget.title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: screenWidth * 0.05,
            color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
          ),
        ),
        backgroundColor:
            isDarkMode ? CupertinoColors.darkBackgroundGray : Colors.white,
        foregroundColor: isDarkMode ? Colors.white : const Color(0xFF1C2526),
        elevation: 0,
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
      body: AnimationLimiter(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.only(
            left: horizontalPadding,
            right: horizontalPadding,
            top: verticalPadding,
            bottom: MediaQuery.of(context).viewInsets.bottom + verticalPadding,
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 10,
            shadowColor: Colors.black.withOpacity(0.3),
            color:
                isDarkMode ? const Color(0xFF1C2526) : const Color(0xFFE8ECEF),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors:
                      isDarkMode
                          ? [const Color(0xFF1C2526), const Color(0xFF2C2C2E)]
                          : [const Color(0xFFE8ECEF), const Color(0xFFDDE4E8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(horizontalPadding),
                child: AnimationConfiguration.staggeredList(
                  position: 0,
                  duration: const Duration(milliseconds: 500),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Timesheet Entry",
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: screenWidth * 0.07,
                              color:
                                  isDarkMode
                                      ? Colors.white
                                      : const Color(0xFF1C2526),
                            ),
                          ),
                          SizedBox(height: verticalPadding),

                          _buildSection(
                            icon: CupertinoIcons.location_solid,
                            label: "Location",
                            child: _buildDropdown(
                              () => _selectedLocation,
                              (val) => setState(() => _selectedLocation = val),
                              TimesheetDummyData.locations,
                              prefixIcon: Icon(
                                CupertinoIcons.location_solid,
                                color:
                                    isDarkMode
                                        ? Colors.white70
                                        : const Color(0xFF5856D6),
                                size: screenWidth * 0.055,
                              ),
                            ),
                            isDarkMode: isDarkMode,
                          ),
                          SizedBox(height: verticalPadding),

                          _buildSection(
                            icon: CupertinoIcons.briefcase_fill,
                            label: "Project",
                            child: _buildDropdown(
                              () => _selectedProject,
                              (val) => setState(() => _selectedProject = val),
                              TimesheetDummyData.projects,
                              prefixIcon: Icon(
                                CupertinoIcons.briefcase_fill,
                                color:
                                    isDarkMode
                                        ? Colors.white70
                                        : const Color(0xFFFF9500),
                                size: screenWidth * 0.055,
                              ),
                            ),
                            isDarkMode: isDarkMode,
                          ),
                          SizedBox(height: verticalPadding),

                          _buildSection(
                            icon: CupertinoIcons.number_circle_fill,
                            label: "Project Code",
                            child: _buildDropdown(
                              () => _selectedProjectCode,
                              (val) =>
                                  setState(() => _selectedProjectCode = val),
                              TimesheetDummyData.projectCodes,
                              prefixIcon: Icon(
                                CupertinoIcons.number_circle_fill,
                                color:
                                    isDarkMode
                                        ? Colors.white70
                                        : const Color(0xFF007AFF),
                                size: screenWidth * 0.055,
                              ),
                            ),
                            isDarkMode: isDarkMode,
                          ),
                          SizedBox(height: verticalPadding),

                          _buildSection(
                            icon: CupertinoIcons.person_2_fill,
                            label: "Employee",
                            child: _buildDropdown(
                              () => _selectedEmployee,
                              (val) => setState(() => _selectedEmployee = val),
                              TimesheetDummyData.employees,
                              prefixIcon: Icon(
                                CupertinoIcons.person_2_fill,
                                color:
                                    isDarkMode
                                        ? Colors.white70
                                        : const Color(0xFF34C759),
                                size: screenWidth * 0.055,
                              ),
                            ),
                            isDarkMode: isDarkMode,
                          ),

                          Divider(
                            height: verticalPadding * 2,
                            thickness: 1.5,
                            color:
                                isDarkMode
                                    ? Colors.white.withOpacity(0.2)
                                    : const Color(0xFFCED4DA),
                          ),

                          _buildSectionTitle(
                            "Site Timings",
                            isDarkMode,
                            screenWidth,
                          ),
                          SizedBox(height: verticalPadding * 0.8),

                          _buildSubTitle(
                            "Onsite Timing",
                            isDarkMode,
                            screenWidth,
                          ),
                          _buildTimingRow(
                            "Sign In",
                            _signInTime,
                            (t) => setState(() => _signInTime = t),
                            isDarkMode,
                            screenWidth,
                            accentColor: const Color(0xFFFF9500),
                          ),
                          _buildTimingRow(
                            "Break Start",
                            _breakStartTime,
                            (t) => setState(() => _breakStartTime = t),
                            isDarkMode,
                            screenWidth,
                            accentColor: const Color(0xFFFF9500),
                          ),
                          _buildTimingRow(
                            "Break End",
                            _breakEndTime,
                            (t) => setState(() => _breakEndTime = t),
                            isDarkMode,
                            screenWidth,
                            accentColor: const Color(0xFFFF9500),
                          ),
                          _buildTimingRow(
                            "Sign Out",
                            _signOutTime,
                            (t) => setState(() => _signOutTime = t),
                            isDarkMode,
                            screenWidth,
                            accentColor: const Color(0xFFFF9500),
                          ),

                          SizedBox(height: verticalPadding),

                          _buildSubTitle(
                            "Offsite Timing",
                            isDarkMode,
                            screenWidth,
                          ),
                          _buildTimingRow(
                            "Travel Start",
                            _travelStartTime,
                            (t) => setState(() => _travelStartTime = t),
                            isDarkMode,
                            screenWidth,
                            accentColor: const Color(0xFFFF9500),
                          ),
                          _buildTimingRow(
                            "Travel End",
                            _travelEndTime,
                            (t) => setState(() => _travelEndTime = t),
                            isDarkMode,
                            screenWidth,
                            accentColor: const Color(0xFFFF9500),
                          ),

                          SizedBox(height: verticalPadding * 1.5),

                          _buildSectionTitle(
                            "Remarks",
                            isDarkMode,
                            screenWidth,
                          ),
                          SizedBox(height: verticalPadding * 0.8),
                          AnimatedOpacity(
                            opacity:
                                _remarksFocusNode.hasFocus ||
                                        _remarksController.text.isNotEmpty
                                    ? 1.0
                                    : 0.7,
                            duration: const Duration(milliseconds: 300),
                            child: TextField(
                              controller: _remarksController,
                              focusNode: _remarksFocusNode,
                              maxLines: 5,
                              style: TextStyle(
                                color:
                                    isDarkMode
                                        ? Colors.white
                                        : const Color(0xFF1C2526),
                                fontSize: screenWidth * 0.042,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                hintText: "Enter any remarks...",
                                hintStyle: TextStyle(
                                  color:
                                      isDarkMode
                                          ? Colors.white54
                                          : const Color(0xFF6B7280),
                                  fontSize: screenWidth * 0.042,
                                ),
                                filled: true,
                                fillColor:
                                    isDarkMode
                                        ? const Color(0xFF2C2C2E)
                                        : const Color(0xFFECEFF1),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color:
                                        isDarkMode
                                            ? Colors.white.withOpacity(0.2)
                                            : const Color(0xFFCED4DA),
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF007AFF),
                                    width: 2.0,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: screenWidth * 0.04,
                                  horizontal: screenWidth * 0.04,
                                ),
                                prefixIcon: null,
                              ),
                            ),
                          ),

                          SizedBox(height: verticalPadding * 2),

                          AppleSubmitButton(
                            onPressed: _submitForm,
                            text: "Submit Timesheet",
                            enabled: true,
                            backgroundColor: const Color(0xFF34C759),
                            textColor: Colors.white,
                            borderRadius: 16,
                            height: screenWidth * 0.14,
                            fontSize: (screenWidth * 0.045).clamp(16, 18),
                            icon: CupertinoIcons.checkmark_circle_fill,
                            iconSize: screenWidth * 0.06,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String label,
    required Widget child,
    required bool isDarkMode,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    return AnimationConfiguration.staggeredList(
      position: 0,
      duration: const Duration(milliseconds: 400),
      child: SlideAnimation(
        horizontalOffset: 30.0,
        child: FadeInAnimation(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: screenWidth * 0.055,
                    color:
                        isDarkMode ? Colors.white70 : const Color(0xFF007AFF),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: screenWidth * 0.045,
                      color:
                          isDarkMode ? Colors.white : const Color(0xFF1C2526),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              child,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDarkMode, double screenWidth) {
    return AnimationConfiguration.staggeredList(
      position: 0,
      duration: const Duration(milliseconds: 400),
      child: SlideAnimation(
        verticalOffset: 20.0,
        child: FadeInAnimation(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: screenWidth * 0.06,
              color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubTitle(String subtitle, bool isDarkMode, double screenWidth) {
    return AnimationConfiguration.staggeredList(
      position: 0,
      duration: const Duration(milliseconds: 400),
      child: SlideAnimation(
        verticalOffset: 20.0,
        child: FadeInAnimation(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenWidth * 0.025),
            child: Text(
              subtitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: screenWidth * 0.05,
                color: isDarkMode ? Colors.white70 : const Color(0xFF1C2526),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String? Function() getValue,
    void Function(String?) onChanged,
    List<Map<String, String>> items, {
    Widget? prefixIcon,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return AnimationConfiguration.staggeredList(
      position: 0,
      duration: const Duration(milliseconds: 400),
      child: SlideAnimation(
        horizontalOffset: 30.0,
        child: FadeInAnimation(
          child: Theme(
            data: Theme.of(context).copyWith(
              highlightColor:
                  isDarkMode ? Colors.white70 : const Color(0xFF1C2526),
              splashColor: Colors.transparent,
              canvasColor:
                  isDarkMode
                      ? const Color(0xFF2C2C2E)
                      : const Color(0xFFECEFF1),
            ),
            child: AppleDropdown<String>(
              items: items.map((e) => e['value']!).toList(),
              selectedItem: getValue(),
              onChanged: onChanged,
              itemLabel:
                  (val) => items.firstWhere((e) => e['value'] == val)['label']!,
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors:
                      isDarkMode
                          ? [const Color(0xFF2C2C2E), const Color(0xFF3A3A3C)]
                          : [const Color(0xFFECEFF1), const Color(0xFFDDE4E8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color:
                      isDarkMode
                          ? Colors.white.withOpacity(0.3)
                          : const Color(0xFFCED4DA),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                        isDarkMode
                            ? const Color(0xFF007AFF).withOpacity(0.4)
                            : Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                    spreadRadius: 1,
                  ),
                ],
              ),
              textStyle: TextStyle(
                fontSize: screenWidth * 0.038,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
              ),
              hint: "Select an option",
              prefixIcon: prefixIcon,
              dropdownMaxHeight: screenHeight * 0.25,
              animationDuration: const Duration(milliseconds: 300),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimingRow(
    String label,
    TimeOfDay? time,
    Function(TimeOfDay) onPicked,
    bool isDarkMode,
    double screenWidth, {
    required Color accentColor,
  }) {
    return AnimationConfiguration.staggeredList(
      position: 0,
      duration: const Duration(milliseconds: 400),
      child: SlideAnimation(
        horizontalOffset: 30.0,
        child: FadeInAnimation(
          child: GestureDetector(
            onTap: () => _pickTime(onPicked),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
              padding: EdgeInsets.all(screenWidth * 0.03),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors:
                      isDarkMode
                          ? [const Color(0xFF2C2C2E), const Color(0xFF3A3A3C)]
                          : [const Color(0xFFECEFF1), const Color(0xFFDDE4E8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color:
                      isDarkMode
                          ? Colors.white.withOpacity(0.3)
                          : const Color(0xFFCED4DA),
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withOpacity(isDarkMode ? 0.3 : 0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: screenWidth * 0.038,
                        fontWeight: FontWeight.w600,
                        color:
                            isDarkMode
                                ? Colors.white70
                                : const Color(0xFF1C2526),
                      ),
                    ),
                  ),
                  Text(
                    time != null ? time.format(context) : "Select Time",
                    style: TextStyle(
                      fontSize: screenWidth * 0.038,
                      color: accentColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    CupertinoIcons.clock_fill,
                    size: screenWidth * 0.045,
                    color: accentColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickTime(Function(TimeOfDay) onPicked) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor:
                  Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF1C2526)
                      : const Color(0xFFF5F7FA),
              hourMinuteTextColor: const Color(0xFF007AFF),
              dialHandColor: const Color(0xFF34C759),
              dialBackgroundColor:
                  Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF2C2C2E)
                      : const Color(0xFFECEFF1),
              entryModeIconColor: const Color(0xFFFF9500),
              dayPeriodTextColor: const Color(0xFF5856D6),
              helpTextStyle: TextStyle(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white70
                        : const Color(0xFF1C2526),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      onPicked(picked);
    }
  }

  void _submitForm() {
    debugPrint("Form Submitted");
    debugPrint("Location: $_selectedLocation");
    debugPrint("Project: $_selectedProject");
    debugPrint("Project Code: $_selectedProjectCode");
    debugPrint("Employee: $_selectedEmployee");
    debugPrint("Remarks: ${_remarksController.text}");
  }

  @override
  void dispose() {
    _remarksController.dispose();
    _remarksFocusNode.dispose();
    super.dispose();
  }
}
