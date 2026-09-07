import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController(text: '123456'); // Hardcoded for demo

  void _verifyOtp() {
    if (_otpController.text == '123456') {
      context.push('/kyc');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP. Use 123456')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: theme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Verify your phone', style: theme.textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text('Enter 6-digit OTP sent to your phone', style: theme.textTheme.bodyLarge),
            const SizedBox(height: 48),
            
            TextField(
              controller: _otpController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: const TextStyle(letterSpacing: 24, fontSize: 24, fontWeight: FontWeight.bold),
              maxLength: 6,
              decoration: const InputDecoration(
                counterText: '',
              ),
            ),
            
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _verifyOtp,
              child: const Text('VERIFY', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Didn't receive?"),
                TextButton(
                  onPressed: () {},
                  child: Text('Resend', style: TextStyle(color: theme.colorScheme.secondary, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
