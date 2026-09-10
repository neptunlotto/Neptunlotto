import 'package:application/features/auth/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neptunlotto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D253F)),
        useMaterial3: true,
        fontFamily: 'Inter', // Assuming standard sans-serif font
      ),
      home: const SplashScreen(),
    );
  }
}
