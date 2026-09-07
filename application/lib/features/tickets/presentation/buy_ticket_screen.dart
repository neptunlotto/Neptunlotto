import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BuyTicketScreen extends StatefulWidget {
  const BuyTicketScreen({super.key});

  @override
  State<BuyTicketScreen> createState() => _BuyTicketScreenState();
}

class _BuyTicketScreenState extends State<BuyTicketScreen> {
  int _currentStep = 0;
  bool _isLoading = false;
  String _generatedTicket = "";

  void _processStep() async {
    setState(() => _isLoading = true);
    
    // Simulate API calls for each step
    await Future.delayed(const Duration(seconds: 1));
    
    if (_currentStep == 3) {
      // Simulate ticket generation from backend
      _generatedTicket = "58392017462";
    }

    setState(() {
      _isLoading = false;
      if (_currentStep < 4) {
        _currentStep++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Ticket'),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: _currentStep == 4 
          ? _buildTicketResult(theme)
          : _buildProcessingSteps(theme),
    );
  }

  Widget _buildProcessingSteps(ThemeData theme) {
    return Stepper(
      currentStep: _currentStep,
      controlsBuilder: (context, details) {
        if (_isLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: ElevatedButton(
            onPressed: _processStep,
            child: Text(_currentStep == 3 ? 'CONFIRM PAYMENT (\$10)' : 'CONTINUE'),
          ),
        );
      },
      steps: [
        Step(
          title: const Text('Check KYC & Account Status'),
          content: const Text('Verifying your identity and account standing with the server...'),
          isActive: _currentStep >= 0,
          state: _currentStep > 0 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: const Text('Payment Method'),
          content: const Text('Secure payment via Wallet Balance (\$125.00 available)'),
          isActive: _currentStep >= 1,
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: const Text('Review Purchase'),
          content: const Text('1x Neptun Lotto Ticket - Draw #1023\nPrice: \$10.00'),
          isActive: _currentStep >= 2,
          state: _currentStep > 2 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: const Text('Generate Ticket'),
          content: const Text('Requesting secure unique 11-digit number from server...'),
          isActive: _currentStep >= 3,
          state: _currentStep > 3 ? StepState.complete : StepState.indexed,
        ),
      ],
    );
  }

  Widget _buildTicketResult(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 24),
            Text(
              'Purchase Successful!',
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: theme.colorScheme.secondary, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.secondary.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text('YOUR TICKET', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 16),
                  Text(
                    _generatedTicket,
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                      color: theme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Draw: #1023', style: theme.textTheme.titleMedium),
                      Text('Price: \$10', style: theme.textTheme.titleMedium),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'ACTIVE',
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.go('/dashboard/home'),
                child: const Text('BACK TO HOME'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
