import 'package:application/features/tickets/screens/ticket_details_screen.dart';
import 'package:application/features/tickets/widgets/ticket_card_widget.dart';
import 'package:flutter/material.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['All', 'Active', 'Won', 'Lost'];

  final List<Map<String, dynamic>> _tickets = [
    {
      'id': 'LOT-1001',
      'number': '58392017462',
      'draw': '#1023',
      'date': '07 Sep 2026',
      'amount': '\$10',
      'status': 'ACTIVE',
      'statusColor': const Color(0xFF00C853), // Green
    },
    {
      'id': 'LOT-1002',
      'number': '92837461520',
      'draw': '#1022',
      'date': '06 Sep 2026',
      'amount': '\$10',
      'status': 'LOST',
      'statusColor': const Color(0xFFE53935), // Red
    },
    {
      'id': 'LOT-1003',
      'number': '10482736591',
      'draw': '#1021',
      'date': '05 Sep 2026',
      'amount': '\$10',
      'status': 'WON',
      'statusColor': const Color(0xFF00C853), // Green
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF031A32),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'My Tickets',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Dark blue background extension behind the white card
          Stack(
            children: [
              Container(height: 40, color: const Color(0xFF031A32)),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                padding: const EdgeInsets.only(top: 24, bottom: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: List.generate(_filters.length, (index) {
                      final isSelected = _selectedFilterIndex == index;
                      return Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedFilterIndex = index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? const Color(0xFF1865F2)
                                      : const Color(0xFFF0F4FF),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text(
                              _filters[index],
                              style: TextStyle(
                                color:
                                    isSelected
                                        ? Colors.white
                                        : const Color(0xFF031A32),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),

          // Ticket List
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: _tickets.length,
                itemBuilder: (context, index) {
                  final ticket = _tickets[index];
                  return _buildTicketCard(ticket, context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketCard(Map<String, dynamic> ticket, BuildContext context) {
    return TicketCardWidget(
      ticket: ticket,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => TicketDetailsScreen(ticket: ticket),
          ),
        );
      },
    );
  }
}
