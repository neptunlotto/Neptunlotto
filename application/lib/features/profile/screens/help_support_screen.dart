import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF031A32),
      appBar: AppBar(
        backgroundColor: const Color(0xFF031A32),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Help & Support',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  children: [
                    // Help Icon
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(
                        Icons.headset_mic_outlined,
                        color: Color(0xFF1865F2),
                        size: 48,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Title
                    const Text(
                      'How can we help you?',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF031A32),
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Menu Items
                    _buildMenuItem(
                      icon: Icons.help_outline,
                      title: 'FAQ',
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _buildMenuItem(
                      icon: Icons.contact_support_outlined,
                      title: 'Contact Support',
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _buildMenuItem(
                      icon: Icons.chat_bubble_outline,
                      title: 'Live Chat',
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _buildMenuItem(
                      icon: Icons.email_outlined,
                      title: 'Email Us',
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _buildMenuItem(
                      icon: Icons.report_problem_outlined,
                      title: 'Report a Problem',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF4A5568), size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF031A32),
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 24),
          ],
        ),
      ),
    );
  }
}
