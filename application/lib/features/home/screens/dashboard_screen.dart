import 'package:application/features/home/screens/home_screen.dart';
import 'package:application/features/profile/screens/profile_screen.dart';
import 'package:application/features/tickets/screens/results_screen.dart';
import 'package:application/features/tickets/screens/tickets_screen.dart';
import 'package:application/features/wallet/screens/wallet_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return HomeScreen(
          onNavigate: (newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
        );
      case 1:
        return const TicketsScreen();
      case 2:
        return const ResultsScreen();
      case 3:
        return const WalletScreen();
      case 4:
        return ProfileScreen(
          onNavigate: (newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
        );
      default:
        return const Center(child: Text('Profile Screen'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreen(_currentIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF1865F2),
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.confirmation_number_outlined),
              activeIcon: Icon(Icons.confirmation_number),
              label: 'Tickets',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events_outlined),
              activeIcon: Icon(Icons.emoji_events),
              label: 'Results',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              activeIcon: Icon(Icons.account_balance_wallet),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
