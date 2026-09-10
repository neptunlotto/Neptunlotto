import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  final List<Map<String, dynamic>> _notifications = const [
    {
      'title': 'You won!',
      'description': 'Your ticket 58392017462 won today\'s draw.',
      'time': '2 min ago',
      'icon': Icons.emoji_events,
      'iconColor': Color(0xFFE53935), // Red
      'bgColor': Color(0xFFFFEBEE), // Light red
    },
    {
      'title': 'Ticket purchased',
      'description': 'Your ticket LOT-1001 is active.',
      'time': '1 hour ago',
      'icon': Icons.local_play,
      'iconColor': Color(0xFF1865F2), // Blue
      'bgColor': Color(0xFFE3F2FD), // Light blue
    },
    {
      'title': 'Draw reminder',
      'description': 'Today\'s draw starts soon.',
      'time': '3 hours ago',
      'icon': Icons.notifications_active,
      'iconColor': Color(0xFFE53935), // Red
      'bgColor': Color(0xFFFFEBEE), // Light red
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF031A32), // Dark blue background for header
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white, size: 32),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF7F9FC), // Light greyish background
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  final notif = _notifications[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icon Container
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: notif['bgColor'],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            notif['icon'],
                            color: notif['iconColor'],
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        
                        // Text Content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notif['title'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF031A32),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                notif['description'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF4A5568),
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                notif['time'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1865F2), // Light blue timestamp
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
