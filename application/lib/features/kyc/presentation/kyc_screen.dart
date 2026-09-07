import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class KycScreen extends StatelessWidget {
  const KycScreen({super.key});

  void _submitKyc(BuildContext context) {
    // For demo: automatically Verified
    context.go('/dashboard/home');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Identity Verification'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: theme.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'KYC/AML verification is required before account activation.',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            _buildTextField('Full Name', theme),
            const SizedBox(height: 16),
            _buildTextField('Date of Birth', theme),
            const SizedBox(height: 16),
            _buildTextField('Country', theme),
            const SizedBox(height: 16),
            _buildTextField('National ID', theme),
            const SizedBox(height: 32),
            
            Text('Passport / ID Document', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.colorScheme.secondary, width: 2, style: BorderStyle.solid),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.upload_file, size: 40, color: theme.colorScheme.secondary),
                    const SizedBox(height: 8),
                    Text('Upload ID', style: TextStyle(color: theme.colorScheme.secondary, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 48),
            
            ElevatedButton(
              onPressed: () => _submitKyc(context),
              child: const Text('SUBMIT FOR VERIFICATION', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter your $label',
          ),
        ),
      ],
    );
  }
}
