import 'package:application/features/auth/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:application/core/providers/auth_provider.dart';
import 'package:application/core/providers/wallet_provider.dart';
import 'package:application/core/providers/lottery_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => WalletProvider()),
        ChangeNotifierProvider(create: (_) => LotteryProvider()),
      ],
      child: const NeptunlottoApp(),
    ),
  );
}

class NeptunlottoApp extends StatelessWidget {
  const NeptunlottoApp({super.key});

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
