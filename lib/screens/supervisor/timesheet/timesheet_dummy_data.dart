// timesheet_dummy_data.dart
class TimesheetDummyData {
  static final List<Map<String, String>> locations = [
    {'value': 'office', 'label': 'Office'},
    {'value': 'remote', 'label': 'Remote'},
    {'value': 'client', 'label': 'Client Site'},
  ];

  static final List<Map<String, String>> projects = [
    {'value': 'proj1', 'label': 'Project Alpha'},
    {'value': 'proj2', 'label': 'Project Beta'},
    {'value': 'proj3', 'label': 'Project Gamma'},
  ];

  static final List<Map<String, String>> employees = [
    {'value': 'emp1', 'label': 'John Doe'},
    {'value': 'emp2', 'label': 'Jane Smith'},
    {'value': 'emp3', 'label': 'Mike Johnson'},
  ];

  static final List<Map<String, String>> projectCodes = [
    {'value': 'PC001', 'label': 'PC001 - Main Building'},
    {'value': 'PC002', 'label': 'PC002 - Renovation'},
  ];
}
