import 'package:application/features/wallet/screens/payment_screen.dart';
import 'package:flutter/material.dart';

class BuyTicketScreen extends StatefulWidget {
  const BuyTicketScreen({super.key});

  @override
  State<BuyTicketScreen> createState() => _BuyTicketScreenState();
}

class _BuyTicketScreenState extends State<BuyTicketScreen> {
  int _ticketQuantity = 1;
  final double _ticketPrice = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF031A32), // Dark blue background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white, size: 32),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Buy Ticket',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // --- 1. Draw Details Section ---
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Today\'s Draw',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF4A5568),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '#1023',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF031A32),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F4FF),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              '07 Sep 2026',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF1865F2),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // --- 2. Ticket Price Card ---
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF5CD), // Light cream
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            'Ticket Price',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF031A32),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '\$10',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF031A32),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Per ticket',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF4A5568),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    const SizedBox(height: 32),

                    // --- 3. Wallet Balance ---
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.account_balance_wallet,
                              color: Color(0xFF1865F2),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Wallet Balance',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF031A32),
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          '\$125.00',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00C853), // Highlighted in green
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // --- 4. Quantity and Total ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total Price',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF4A5568),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${(_ticketQuantity * _ticketPrice).toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF031A32),
                              ),
                            ),
                          ],
                        ),

                        // Quantity Selector
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F4FF), // Light blue
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFD6E4FF)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove,
                                  color: Color(0xFF031A32),
                                ),
                                onPressed: () {
                                  if (_ticketQuantity > 1) {
                                    setState(() {
                                      _ticketQuantity--;
                                    });
                                  }
                                },
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Text(
                                  '$_ticketQuantity',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF031A32),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  color: Color(0xFF031A32),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _ticketQuantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Buy Now Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const PaymentScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFF1865F2,
                          ), // Bright blue
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Buy Now',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Footer Text
                    const Text(
                      'Good luck!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF031A32),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Play responsibly.',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
