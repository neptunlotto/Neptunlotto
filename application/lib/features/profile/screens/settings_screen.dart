import 'package:application/features/profile/screens/help_support_screen.dart';
import 'package:application/features/profile/screens/responsible_gaming_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
          'Settings',
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Column(
                  children: [
                    _buildMenuItem(
                      icon: Icons.person_outline,
                      title: 'Account',
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _buildMenuItem(
                      icon: Icons.security,
                      title: 'Security',
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _buildMenuItem(
                      icon: Icons.notifications_none,
                      title: 'Notifications',
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _buildMenuItem(
                      icon: Icons.language,
                      title: 'Language',
                      trailingText: 'English',
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _buildMenuItem(
                      icon: Icons.description_outlined,
                      title: 'Terms & Conditions',
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _buildMenuItem(
                      icon: Icons.privacy_tip_outlined,
                      title: 'Privacy Policy',
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _buildMenuItem(
                      icon: Icons.info_outline,
                      title: 'Responsible Gaming',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ResponsibleGamingScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _buildMenuItem(
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const HelpSupportScreen(),
                          ),
                        );
                      },
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
    String? trailingText,
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
            if (trailingText != null) ...[
              Text(
                trailingText,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF4A5568),
                ),
              ),
              const SizedBox(width: 8),
            ],
            const Icon(Icons.chevron_right, color: Colors.grey, size: 24),
          ],
        ),
      ),
    );
  }
}
