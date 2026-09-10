import 'package:application/features/home/screens/notifications_screen.dart';
import 'package:application/features/profile/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Function(int)? onNavigate;

  const ProfileScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: Column(
        children: [
          // Dark blue background extension behind the white card, including status bar
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height:
                    MediaQuery.of(context).padding.top +
                    100, // Covers status bar + some space
                color: const Color(0xFF031A32),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 50,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                padding: const EdgeInsets.only(
                  top: 0,
                  bottom: 24,
                  left: 24,
                  right: 24,
                ),
                child: Column(
                  children: [
                    // Avatar overlaying the top border
                    Transform.translate(
                      offset: const Offset(0, -40),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundColor: Color(0xFF1865F2),
                          // Use person icon as placeholder for avatar
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    // Profile Info
                    Transform.translate(
                      offset: const Offset(0, -24),
                      child: Column(
                        children: [
                          const Text(
                            'Rajnikant',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF031A32),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'rajnikanti@example.com',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // KYC Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F5E9), // Light green
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF00C853),
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'KYC Verified',
                                  style: TextStyle(
                                    color: Color(0xFF00C853),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                    _buildMenuItem(
                      icon: Icons.person_outline,
                      title: 'Personal Information',
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _buildMenuItem(
                      icon: Icons.account_balance_wallet_outlined,
                      title: 'Wallet',
                      onTap:
                          () => onNavigate?.call(3), // Navigate to Wallet tab
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _buildMenuItem(
                      icon: Icons.confirmation_number_outlined,
                      title: 'My Tickets',
                      onTap:
                          () => onNavigate?.call(1), // Navigate to Tickets tab
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _buildMenuItem(
                      icon: Icons.notifications_none,
                      title: 'Notifications',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const NotificationsScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _buildMenuItem(
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SettingsScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _buildMenuItem(
                      icon: Icons.logout,
                      title: 'Logout',
                      color: Colors.redAccent,
                      onTap: () {
                        // TODO: Implement actual logout logic here
                        // Example: Navigator.of(context).pushReplacement(...);
                      },
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

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            Icon(icon, color: color ?? const Color(0xFF4A5568), size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color ?? const Color(0xFF031A32),
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: color ?? Colors.grey, size: 24),
          ],
        ),
      ),
    );
  }
}
