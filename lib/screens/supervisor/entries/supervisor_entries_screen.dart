import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SupervisorEntriesScreen extends StatefulWidget {
  const SupervisorEntriesScreen({super.key});

  @override
  State<SupervisorEntriesScreen> createState() =>
      _SupervisorEntriesScreenState();
}

class _SupervisorEntriesScreenState extends State<SupervisorEntriesScreen> {
  String selectedCategory = 'All';

  final List<String> categories = ['All', 'Submitted', 'Draft'];

  final List<Map<String, String>> entries = [
    {
      'project': 'Residential Tower',
      'location': 'Delhi',
      'date': '12 July 2025',
      'employees': '18',
      'hours': '144',
      'status': 'Submitted',
    },
    {
      'project': 'School Renovation',
      'location': 'Mumbai',
      'date': '11 July 2025',
      'employees': '10',
      'hours': '80',
      'status': 'Draft',
    },
    {
      'project': 'Mall Construction',
      'location': 'Lucknow',
      'date': '09 July 2025',
      'employees': '22',
      'hours': '176',
      'status': 'Submitted',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: const Text(
          'Entries',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildCategorySelector(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                if (selectedCategory != 'All' &&
                    entry['status'] != selectedCategory) {
                  return const SizedBox.shrink();
                }
                return _buildEntryCard(entry);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Category chips selector at top
  Widget _buildCategorySelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            categories.map((category) {
              final isSelected = category == selectedCategory;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = category;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isSelected ? Colors.blueAccent : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  /// Each entry card
  Widget _buildEntryCard(Map<String, String> entry) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry['project']!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  CupertinoIcons.location,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 6),
                Text(
                  entry['location']!,
                  style: TextStyle(color: Colors.grey.shade800),
                ),
                const Spacer(),
                Icon(
                  CupertinoIcons.calendar,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 6),
                Text(
                  entry['date']!,
                  style: TextStyle(color: Colors.grey.shade800),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildInfoChip(Icons.groups, '${entry['employees']} employees'),
                const SizedBox(width: 10),
                _buildInfoChip(Icons.access_time, '${entry['hours']} hrs'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildStatusChip(entry['status']!),
                const Spacer(),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(14),
                  child: const Text('View', style: TextStyle(fontSize: 14)),
                  onPressed: () {
                    // TODO: View details action
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Info chip widget (icon + text)
  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.black54),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  /// Status chip widget (colored chip)
  Widget _buildStatusChip(String status) {
    Color chipColor;
    switch (status) {
      case 'Submitted':
        chipColor = Colors.green;
        break;
      case 'Draft':
        chipColor = Colors.orange;
        break;
      default:
        chipColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: chipColor,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }
}
