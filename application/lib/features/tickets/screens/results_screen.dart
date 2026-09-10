import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  final List<String> _winningNumbers = const [
    '58392017462',
    '92837461520',
    '10482736591',
    '47281930564',
    '81726394015',
    '39281746520',
    '62019483751',
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
          'Draw Results',
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
                      'Draw #1023',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF031A32),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '07 Sep 2026',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          Expanded(
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // Congratulations Banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE3F2FD), Color(0xFFE8F5E9)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            '🎉 Congratulations',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF031A32),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'to all the winners!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF4A5568),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Winners List Container
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: List.generate(_winningNumbers.length, (index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                child: Row(
                                  children: [
                                    Text(
                                      (index + 1).toString().padLeft(2, '0'),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF4A5568),
                                      ),
                                    ),
                                    const SizedBox(width: 32),
                                    Text(
                                      _winningNumbers[index],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF031A32),
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    const Spacer(),
                                    if (_winningNumbers[index] == '58392017462') // Mock user ticket for Draw #1023
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF00C853).withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Text(
                                          'You',
                                          style: TextStyle(
                                            color: Color(0xFF00C853),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if (index < _winningNumbers.length - 1)
                                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                            ],
                          );
                        }),
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // View Previous Draws Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF1865F2),
                          side: const BorderSide(color: Color(0xFF1865F2), width: 2),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'View Previous Draws',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
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
