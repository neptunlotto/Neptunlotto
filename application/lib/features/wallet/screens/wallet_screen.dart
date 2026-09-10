import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  final List<Map<String, dynamic>> _transactions = const [
    {
      'title': 'Prize',
      'date': '06 Sep 2026',
      'amount': '+ \$100.00',
      'isPositive': true,
    },
    {
      'title': 'Ticket Purchase',
      'date': '07 Sep 2026',
      'amount': '- \$10.00',
      'isPositive': false,
    },
    {
      'title': 'Ticket Purchase',
      'date': '06 Sep 2026',
      'amount': '- \$10.00',
      'isPositive': false,
    },
    {
      'title': 'Prize',
      'date': '05 Sep 2026',
      'amount': '+ \$50.00',
      'isPositive': true,
    },
    {
      'title': 'Ticket Purchase',
      'date': '05 Sep 2026',
      'amount': '- \$10.00',
      'isPositive': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF031A32),
        elevation: 0,
        automaticallyImplyLeading: false, // No back button needed
        title: const Text(
          'Wallet',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Dark blue background extension behind the white card
          Stack(
            children: [
              Container(
                height: 40,
                color: const Color(0xFF031A32),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                padding: const EdgeInsets.only(top: 32, bottom: 24, left: 24, right: 24),
                child: Column(
                  children: [
                    const Text(
                      '\$125.00',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF031A32),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Available Balance',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1865F2), // Bright blue
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Add Money',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF0F4FF), // Light grey/blue
                              foregroundColor: const Color(0xFF031A32),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Withdraw',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                    child: Text(
                      'Transactions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF031A32),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      itemCount: _transactions.length,
                      separatorBuilder: (context, index) => const Divider(
                        color: Color(0xFFE2E8F0),
                        height: 32,
                      ),
                      itemBuilder: (context, index) {
                        final tx = _transactions[index];
                        return _buildTransactionRow(tx);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionRow(Map<String, dynamic> tx) {
    final bool isPositive = tx['isPositive'];
    
    return Row(
      children: [
        // Icon Container
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isPositive 
                ? const Color(0xFFE8F5E9) // Light green
                : const Color(0xFFFFEBEE), // Light red
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            isPositive ? Icons.emoji_events : Icons.local_play,
            color: isPositive ? const Color(0xFF00C853) : const Color(0xFFE53935),
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        
        // Title and Date
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tx['title'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF031A32),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                tx['date'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        
        // Amount
        Text(
          tx['amount'],
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: isPositive ? const Color(0xFF00C853) : const Color(0xFFE53935),
          ),
        ),
      ],
    );
  }
}
