import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/splash/presentation/splash_screen.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/register_screen.dart';
import '../features/auth/presentation/forgot_password_screen.dart';
import '../features/auth/presentation/otp_screen.dart';
import '../features/kyc/presentation/kyc_screen.dart';
import '../features/home/presentation/dashboard_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/tickets/presentation/my_tickets_screen.dart';
import '../features/draws/presentation/results_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/wallet/presentation/wallet_screen.dart';
import '../features/tickets/presentation/buy_ticket_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) => const OtpScreen(),
    ),
    GoRoute(
      path: '/kyc',
      builder: (context, state) => const KycScreen(),
    ),
    // Standalone screens
    GoRoute(
      path: '/wallet',
      builder: (context, state) => const WalletScreen(),
    ),
    GoRoute(
      path: '/buy-ticket',
      builder: (context, state) => const BuyTicketScreen(),
    ),
    GoRoute(
      path: '/ticket-details',
      builder: (context, state) => const PlaceholderScreen(title: 'Ticket Details'),
    ),
    GoRoute(
      path: '/draw-details',
      builder: (context, state) => const PlaceholderScreen(title: 'Draw Details'),
    ),
    GoRoute(
      path: '/transactions',
      builder: (context, state) => const PlaceholderScreen(title: 'Transactions'),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const PlaceholderScreen(title: 'Settings'),
    ),
    GoRoute(
      path: '/support',
      builder: (context, state) => const PlaceholderScreen(title: 'Support'),
    ),
    // Dashboard Shell
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return DashboardScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/dashboard/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/dashboard/tickets',
          builder: (context, state) => const MyTicketsScreen(),
        ),
        GoRoute(
          path: '/dashboard/results',
          builder: (context, state) => const ResultsScreen(),
        ),
        GoRoute(
          path: '/dashboard/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title)),
    );
  }
}
