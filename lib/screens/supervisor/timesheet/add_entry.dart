import 'package:flutter/material.dart';
import 'timesheet_dummy_data.dart'; // Import the dummy data file

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

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Section
            Text(
              widget.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Dropdown Sections using Dummy Data
            _buildDropdownRow(
              label: 'Select Location',
              items: TimesheetDummyData.locations,
              value: _selectedLocation,
              onChanged: (value) => setState(() => _selectedLocation = value),
            ),
            const SizedBox(height: 16),

            _buildDropdownRow(
              label: 'Select Project',
              items: TimesheetDummyData.projects,
              value: _selectedProject,
              onChanged: (value) => setState(() => _selectedProject = value),
            ),
            const SizedBox(height: 16),

            _buildDropdownRow(
              label: 'Project Code',
              items: TimesheetDummyData.projectCodes,
              value: _selectedProjectCode,
              onChanged:
                  (value) => setState(() => _selectedProjectCode = value),
            ),
            const SizedBox(height: 16),

            _buildDropdownRow(
              label: 'Select Employees',
              items: TimesheetDummyData.employees,
              value: _selectedEmployee,
              onChanged: (value) => setState(() => _selectedEmployee = value),
            ),

            const Divider(height: 40),

            // Site Timings Section
            const Text(
              'Site Timings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Onsite Timing
            const Text(
              'Onsite Timing',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            _buildTimingTable(
              showSignIn: true,
              showBreak: true,
              showSignOut: true,
            ),

            const SizedBox(height: 24),

            // Offsite Timing
            const Text(
              'Offsite Timing',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            _buildTimingTable(
              showSignIn: false,
              showBreak: false,
              showSignOut: false,
            ),
            const SizedBox(height: 8),

            // Remarks Row
            Row(
              children: [
                const Expanded(child: Text('Remarks')),
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) => Colors.blue,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Updated Dropdown Builder to work with dummy data
  Widget _buildDropdownRow({
    required String label,
    required List<Map<String, String>> items,
    required String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      value: value,
      items:
          items.map((item) {
            return DropdownMenuItem<String>(
              value: item['value'],
              child: Text(item['label']!),
            );
          }).toList(),
      onChanged: onChanged,
    );
  }

  // Timing Table Builder (unchanged from your original)
  Widget _buildTimingTable({
    required bool showSignIn,
    required bool showBreak,
    required bool showSignOut,
  }) {
    return Table(
      columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(3)},
      children: [
        if (showSignIn)
          TableRow(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Sign In'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('✅'),
              ),
            ],
          ),
        if (showBreak)
          TableRow(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Break Start'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Break End'),
              ),
            ],
          ),
        if (showSignOut)
          TableRow(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Sign Out'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('✅'),
              ),
            ],
          ),
        TableRow(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Travel Start'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Travel End'),
            ),
          ],
        ),
      ],
    );
  }

  // Form Submission Handler
  void _submitForm() {
    debugPrint('Form Submitted with:');
    debugPrint('Location: $_selectedLocation');
    debugPrint('Project: $_selectedProject');
    debugPrint('Project Code: $_selectedProjectCode');
    debugPrint('Employee: $_selectedEmployee');
    // Add your form submission logic here
  }
}
