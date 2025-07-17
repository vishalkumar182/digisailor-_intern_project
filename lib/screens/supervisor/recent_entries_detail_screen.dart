import 'package:flutter/material.dart';

/// Screen to display detailed view of recent entries
class RecentEntriesDetailScreen extends StatelessWidget {
  final List<Map<String, String>> entries = [
    {'title': 'Safety Check Completed', 'time': '10:30 AM', 'date': 'Jul 16'},
    {
      'title': 'Material Delivery Arrived',
      'time': '11:15 AM',
      'date': 'Jul 16',
    },
    {'title': 'Team Meeting Scheduled', 'time': '02:00 PM', 'date': 'Jul 16'},
    {
      'title': 'Equipment Maintenance Done',
      'time': '09:45 AM',
      'date': 'Jul 15',
    },
  ];

  RecentEntriesDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade50, // Set background to match dashboard
      appBar: AppBar(
        title: const Text('Recent Entries'),
        backgroundColor: const Color(0xFF007AFF),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(screenWidth * 0.03),
                  leading: Icon(
                    Icons.event_note,
                    color: const Color(0xFFFF9500),
                    size: screenWidth * 0.05,
                  ),
                  title: Text(
                    entries[index]['title']!,
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1C2526),
                    ),
                  ),
                  subtitle: Text(
                    '${entries[index]['time']!} - ${entries[index]['date']!}',
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
