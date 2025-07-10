import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:construction_manager_app/widgets/animated_heading.dart';

// Importing model for onboarding page data
import 'package:construction_manager_app/models/onboarding/onboarding_page_model.dart';

// Importing login screen to navigate after onboarding
import 'package:construction_manager_app/screens/auth/login_screen.dart';

/// Main Onboarding Screen which shows multiple onboarding pages with animations
class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<Onboarding> {
  // Controller for the PageView to switch pages programmatically
  final PageController _pageController = PageController();

  // Track current page index for updating UI elements
  int _currentPage = 0;

  // List of onboarding pages with their data (title, description, animation, background color)
  final List<OnboardingPageData> _pages = [
    OnboardingPageData(
      title: "Let's manage!",
      description: "Streamline the projects you always wanted to complete",
      lottieAsset: 'assets/animations/construction_site.json',
      bgColor: Color(0xFFF8F9FA),
    ),
    OnboardingPageData(
      title: "Team Collaboration",
      description: "Get notified and stay updated with your team's progress",
      lottieAsset: 'assets/animations/construction_site2.json',
      bgColor: Color(0xFFF8F9FA),
    ),
    OnboardingPageData(
      title: "Track Projects",
      description: "Monitor all your projects in one centralized dashboard",
      lottieAsset: 'assets/animations/construction_site3.json',
      bgColor: Color(0xFFF8F9FA),
    ),
    OnboardingPageData(
      title: "Smart Recommendations",
      description: "We suggest the best approaches for your projects",
      lottieAsset: 'assets/animations/construction_site4.json',
      bgColor: Color(0xFFF8F9FA),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set background color depending on current page
      backgroundColor: _pages[_currentPage].bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top-right Skip button to jump to Login screen directly
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 16),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => _navigateToLogin(context),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Color(0xFF495057),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            // Main content: swipeable onboarding pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    data: _pages[index],
                    isLastPage: index == _pages.length - 1,
                    onGetStarted: () => _navigateToLogin(context),
                  );
                },
              ),
            ),

            // Bottom row: smooth page indicator + Next/Get Started button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _pages.length,
                    effect: WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 8,
                      activeDotColor: Color(0xFF495057),
                      dotColor: Color(0xFFCED4DA),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage < _pages.length - 1) {
                        // Move to next onboarding page
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        // Last page => navigate to Login screen
                        _navigateToLogin(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF495057),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 14,
                      ),
                    ),
                    child: Text(
                      _currentPage == _pages.length - 1
                          ? 'Get Started'
                          : 'Continue',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to navigate to LoginScreen and replace onboarding screen
  void _navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ), //avoid using const keyword
    );
  }
}

/// Widget for single onboarding page with animation, title and description
class OnboardingPage extends StatelessWidget {
  final OnboardingPageData data;
  final bool isLastPage;
  final VoidCallback onGetStarted;

  const OnboardingPage({
    super.key,
    required this.data,
    required this.isLastPage,
    required this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 16),

          // Animated Lottie visual
          Expanded(
            flex: 6,
            child: Lottie.asset(
              data.lottieAsset,
              fit: BoxFit.contain,
              width: screenSize.width * 0.95,
            ),
          ),

          const SizedBox(height: 32),

          // Title text
          AnimatedHeading(
            text: data.title,
            style: const TextStyle(
              color: Color(0xFF212529),
              fontSize: 26,
              fontWeight: FontWeight.w700,
              height: 1.35,
            ),
          ),

          const SizedBox(height: 16),

          // Description text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              data.description,
              style: const TextStyle(
                color: Color.fromARGB(255, 3, 10, 17),
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
