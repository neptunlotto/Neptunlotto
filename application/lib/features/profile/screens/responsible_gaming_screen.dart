import 'package:flutter/material.dart';

class ResponsibleGamingScreen extends StatelessWidget {
  const ResponsibleGamingScreen({super.key});

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
          'Responsible Gaming',
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
                    // Shield Icon
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(
                        Icons.verified_user,
                        color: Color(0xFF00C853),
                        size: 48,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Title & Subtitle
                    const Text(
                      'Play Responsibly',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF031A32),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'We care about your well-being.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Menu Items
                    _buildMenuItem(
                      icon: Icons.monetization_on_outlined,
                      title: 'Set Spending Limits',
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _buildMenuItem(
                      icon: Icons.block,
                      title: 'Self-Exclusion',
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _buildMenuItem(
                      icon: Icons.access_time,
                      title: 'Time Reminders',
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _buildMenuItem(
                      icon: Icons.support_agent,
                      title: 'Get Help',
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
