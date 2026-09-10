import 'package:application/features/wallet/screens/payment_processing_screen.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedMethod = 'Wallet'; // Default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF031A32),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Payment',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),

              // Order Summary Section
              const Text(
                'Order Summary',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF031A32),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Lottery Ticket',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF031A32),
                          ),
                        ),
                        Text(
                          '\$10.00',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF031A32),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Draw #1023',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Payment Method Section
              const Text(
                'Payment Method',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF031A32),
                ),
              ),
              const SizedBox(height: 16),

              _buildPaymentOption(
                title: 'Wallet',
                subtitle: 'Available Balance: \$125.00',
                icon: Icons.account_balance_wallet_outlined,
                value: 'Wallet',
              ),
              const SizedBox(height: 16),
              _buildPaymentOption(
                title: 'Credit / Debit Card',
                subtitle: 'Powered by Stripe',
                icon: Icons.credit_card,
                value: 'Card',
              ),
              const SizedBox(height: 16),
              _buildPaymentOption(
                title: 'Other',
                subtitle: 'Apple Pay, Google Pay',
                icon: Icons.devices_other,
                value: 'Other',
              ),

              const Spacer(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF4A5568),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '\$10.00',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1865F2),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const PaymentProcessingScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1865F2),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'PAY \$10.00',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
  }) {
    final isSelected = _selectedMethod == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE3F2FD) : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF1865F2) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color:
                  isSelected
                      ? const Color(0xFF1865F2)
                      : const Color(0xFF4A5568),
              size: 28,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:
                          isSelected
                              ? const Color(0xFF1865F2)
                              : const Color(0xFF031A32),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color:
                          isSelected
                              ? const Color(0xFF1865F2).withOpacity(0.8)
                              : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      isSelected
                          ? const Color(0xFF1865F2)
                          : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child:
                  isSelected
                      ? Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1865F2),
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                      : null,
            ),
          ],
        ),
      ),
    );
  }
}
