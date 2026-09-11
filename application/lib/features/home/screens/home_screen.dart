import 'dart:async';
import 'package:application/features/home/screens/notifications_screen.dart';
import 'package:application/features/tickets/screens/buy_ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:application/core/providers/auth_provider.dart';
import 'package:application/core/providers/wallet_provider.dart';
import 'package:application/core/providers/lottery_provider.dart';

class HomeScreen extends StatefulWidget {
  final Function(int)? onNavigate;

  const HomeScreen({super.key, this.onNavigate});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _timer;
  Duration _timeLeft = const Duration(hours: 24);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      final lotteryProvider = Provider.of<LotteryProvider>(context, listen: false);
      if (lotteryProvider.upcomingDraw != null) {
        final now = DateTime.now();
        if (lotteryProvider.upcomingDraw!.drawDate.isAfter(now)) {
          setState(() {
            _timeLeft = lotteryProvider.upcomingDraw!.drawDate.difference(now);
          });
        } else {
          // Draw time reached!
          lotteryProvider.simulateDrawExecution(
            Provider.of<WalletProvider>(context, listen: false),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final walletProvider = Provider.of<WalletProvider>(context);
    final lotteryProvider = Provider.of<LotteryProvider>(context);
    final userName = authProvider.currentUser?.name ?? 'Player';
    final walletBalance = '\$${walletProvider.balance.toStringAsFixed(2)}';
    final ticketCount = '${lotteryProvider.tickets.length} Tickets';
    final drawId = lotteryProvider.upcomingDraw?.id.replaceAll('draw_', '#') ?? '#---';
    
    String hours = _timeLeft.inHours.toString().padLeft(2, '0');
    String minutes = (_timeLeft.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (_timeLeft.inSeconds % 60).toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC), // Light greyish blue background
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // 1. Top dark blue background
            Container(
              height: 400,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF031A32), // Dark blue top
                    Color(0xFF0044A5), // Mid blue
                    Color(0xFF4FA0FF), // Radiant light blue
                    Color(0xFFF7F9FC), // Fades into main background
                  ],
                  stops: [0.0, 0.4, 0.8, 1.0],
                ),
              ),
            ),

            // 2. Main content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    // Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, $userName 👋',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Your Chance. Your Draw.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const NotificationsScreen(),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Color(0xFF1865F2),
                                radius: 24,
                                child: Icon(Icons.notifications_none, color: Colors.white),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.redAccent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Text(
                                    '2',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Next Draw Card (Buy Ticket)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Next Draw',
                                style: TextStyle(
                                  color: Color(0xFF4A5568),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                                Text(
                                  drawId,
                                  style: const TextStyle(
                                    color: Color(0xFF031A32),
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              const SizedBox(height: 16),

                              const Text(
                                'Starts in',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  _buildTimeBox(hours),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4.0,
                                    ),
                                    child: Text(
                                      ':',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  _buildTimeBox(minutes),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4.0,
                                    ),
                                    child: Text(
                                      ':',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  _buildTimeBox(seconds),
                                ],
                              ),

                              const SizedBox(height: 24),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => const BuyTicketScreen(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1865F2),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'Buy Ticket',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Placeholder for the Lotto Balls image
                          Positioned(
                            top: -60,
                            right: -20,
                            child: SizedBox(
                              width: 180,
                              height: 180,
                              // TODO: Replace Placeholder with Image.asset('assets/balls.png') when available
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    'assets/bingo.png',
                                    width: 180, // Let it fill the container
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Ticket Price Badge
                          Positioned(
                            right: 0,
                            top: 80,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFFFFF5CD,
                                ), // Light cream/yellow
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    'Ticket Price',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF031A32), // Dark text
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFFFFCC00,
                                      ), // Bright gold
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      '\$10',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF031A32), // Dark text
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Quick Actions Row
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap:
                                () => widget.onNavigate?.call(3), // Wallet is index 3
                            child: _buildQuickActionCard(
                              Icons.account_balance_wallet_outlined,
                              'Wallet',
                              walletBalance,
                              Colors.teal,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap:
                                () => widget.onNavigate?.call(1), // Tickets is index 1
                            child: _buildQuickActionCard(
                              Icons.confirmation_number_outlined,
                              'My Tickets',
                              ticketCount,
                              Colors.purple,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap:
                                () => widget.onNavigate?.call(2), // Results is index 2
                            child: _buildQuickActionCard(
                              Icons.emoji_events_outlined,
                              'Results',
                              'Latest',
                              Colors.indigo,
                            ),
                          ),
                        ),
                      ],
                    ),


                    const SizedBox(height: 24),

                    // Today's Winners
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Today\'s Winners',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF031A32),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  widget.onNavigate?.call(2);
                                },
                                child: const Text(
                                  'View All Results',
                                  style: TextStyle(
                                    color: Color(0xFF1865F2),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildWinnerRow('58392017462', 1),
                          _buildWinnerRow('92837461820', 2),
                          _buildWinnerRow('10482736591', 3),
                          _buildWinnerRow('47281930564', 4),
                          _buildWinnerRow('81726394015', 5),
                          _buildWinnerRow('39281746520', 6),
                          _buildWinnerRow('62019483751', 7),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeBox(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4FF), // light blue tint
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF031A32),
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF031A32),
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWinnerRow(String number, int rank) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Color(0xFFFFD700), // Gold
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '#$rank',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B6508),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            number,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4A5568),
            ),
          ),
        ],
      ),
    );
  }
}
