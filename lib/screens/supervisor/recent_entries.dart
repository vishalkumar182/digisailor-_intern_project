import 'package:construction_manager_app/screens/supervisor/recent_entries_detail_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

/// Widget to display recent entries with auto-scrolling functionality
class RecentEntries extends StatefulWidget {
  const RecentEntries({super.key});

  @override
  State<RecentEntries> createState() => _RecentEntriesState();
}

class _RecentEntriesState extends State<RecentEntries> {
  final List<Map<String, String>> _entries = [
    {'title': 'Safety Check Completed', 'time': '10:30 AM', 'date': 'Jul 16'},
    {
      'title': 'Material Delivery Arrived',
      'time': '11:15 AM',
      'date': 'Jul 16',
    },
    {'title': 'Team Meeting Scheduled', 'time': '02:00 PM', 'date': 'Jul 16'},
  ];
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9); // Initialize here
    _startAutoScroll();
  }

  @override
  void didUpdateWidget(covariant RecentEntries oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_pageController.hasClients) {
      _pageController = PageController(viewportFraction: 0.9);
      _startAutoScroll();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  /// Starts the auto-scrolling timer
  void _startAutoScroll() {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _entries.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecentEntriesDetailScreen()),
        );
      },
      child: SizedBox(
        height: screenWidth * 0.3, // Increased height for better visibility
        child: PageView.builder(
          controller: _pageController,
          itemCount: _entries.length,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                color: Colors.white,
                shadowColor: Colors.black.withOpacity(0.1),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFFF9500).withOpacity(0.1),
                        Colors.white,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _entries[index]['title']!,
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1C2526),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: screenWidth * 0.02),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: screenWidth * 0.04,
                            color: Colors.grey.shade600,
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Text(
                            '${_entries[index]['time']!} - ${_entries[index]['date']!}',
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
