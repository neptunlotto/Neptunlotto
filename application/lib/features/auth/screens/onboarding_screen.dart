import 'package:application/features/auth/screens/signin_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _images = [
    'assets/onboard1.png',
    'assets/onboard2.png',
    'assets/onboard3.png',
  ];

  final List<String> _titles = ['Play', 'Daily Draws', 'Track Your Results'];

  final List<String> _subtitles = [
    'A smarter way\nto play the lottery',
    'Participate in exciting\ndaily draws',
    'View your tickets and\ncheck if you\'re a winner',
  ];

  void _onNext() {
    if (_currentPage < _images.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to Login Screen
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }

  void _onSkip() {
    // Navigate straight to Login Screen
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF031A32),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_images[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),

          // Gradient Overlay and Content
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    const Color(0xFF031A32).withOpacity(0.7),
                    const Color(0xFF031A32).withOpacity(0.95),
                    const Color(0xFF031A32),
                  ],
                  stops: const [0.0, 0.4, 0.8, 1.0],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _titles[_currentPage],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _subtitles[_currentPage],
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 22,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _images.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              _currentPage == index
                                  ? const Color(0xFF1865F2) // Bright blue
                                  : Colors.white.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Skip and Next Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: _onSkip,
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _onNext,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFF1865F2,
                          ), // Bright blue
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          _currentPage == _images.length - 1
                              ? 'Get Started'
                              : 'Next',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
