import 'package:application/features/tickets/screens/ticket_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class PaymentProcessingScreen extends StatefulWidget {
  const PaymentProcessingScreen({super.key});

  @override
  State<PaymentProcessingScreen> createState() =>
      _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a 3-second network request to a payment provider
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const TicketConfirmationScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF031A32),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),

                // Loading Indicator
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1865F2)),
                  strokeWidth: 4,
                ),
                const SizedBox(height: 32),

                const Text(
                  'Processing Payment',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                const Text(
                  'Please don\'t close\nthe application.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 48),

                const Text(
                  'Verifying payment...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1865F2),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
