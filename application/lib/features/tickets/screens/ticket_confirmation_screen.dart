import 'package:application/features/tickets/screens/ticket_details_screen.dart';
import 'package:flutter/material.dart';

class TicketConfirmationScreen extends StatelessWidget {
  const TicketConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF031A32), // Dark blue background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Success Icon with Glow
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF00C853), // Green
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00C853).withOpacity(0.4),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 60),
              ),

              const SizedBox(height: 32),

              // Success Text
              const Text(
                'Purchase Successful!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your ticket has been purchased.',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),

              const SizedBox(height: 40),

              // Ticket Stub Card
              _buildTicketStub(),

              const SizedBox(height: 32),

              // View Ticket Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (_) => const TicketDetailsScreen(
                              ticket: {
                                'id': 'LOT-1004',
                                'number': '58392017462',
                                'draw': '#1023',
                                'date': '07 Sep 2026',
                                'amount': '\$10',
                                'status': 'PENDING',
                              },
                            ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1865F2), // Bright blue
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'View Ticket',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Buy Another Ticket Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pop(); // Go back to Buy Ticket / Dashboard
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1865F2),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Buy Another Ticket',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketStub() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          // Top dark section
          Container(
            height: 120,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF031A32),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              image: DecorationImage(
                image: const AssetImage('assets/ticket.png'),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/lotto_logo.png',
                height: 60,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Jagged/Dashed Divider Effect
          SizedBox(
            height: 20,
            child: Stack(
              children: [
                Positioned(
                  left: -10,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 20,
                    decoration: const BoxDecoration(
                      color: Color(0xFF031A32),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  right: -10,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 20,
                    decoration: const BoxDecoration(
                      color: Color(0xFF031A32),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            (constraints.constrainWidth() / 8).floor(),
                            (index) {
                              return SizedBox(
                                width: 4,
                                height: 2,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Ticket Details
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Column(
                  children: [
                    Text(
                      'Ticket Number',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '58392017462',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF031A32),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                _buildDetailRow('Draw', '#1023'),
                _buildDetailRow('Date', '07 Sep 2026'),
                _buildDetailRow('Amount', '\$10', isBold: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF4A5568),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: const Color(0xFF031A32),
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
