import 'dart:async';
import 'package:application/features/auth/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _preloaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_preloaded) {
      // Preload the first onboarding image to prevent a white flash when it loads
      precacheImage(const AssetImage('assets/onboard1.png'), context);
      _preloaded = true;
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder:
              (context, animation, secondaryAnimation) =>
                  const OnboardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/splash_back.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/lotto_logo.png',
                  height: 120, // Large logo for splash screen
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
