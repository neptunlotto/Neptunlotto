import 'package:flutter/material.dart';
import 'dart:async';

enum KycStatus { pending, verified, rejected }

class KycStatusScreen extends StatefulWidget {
  final KycStatus status;

  const KycStatusScreen({super.key, required this.status});

  @override
  State<KycStatusScreen> createState() => _KycStatusScreenState();
}

class _KycStatusScreenState extends State<KycStatusScreen> {
  late KycStatus _currentStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.status;
    
    // Simulate backend verification process
    if (_currentStatus == KycStatus.pending) {
      Timer(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _currentStatus = KycStatus.verified; // Auto-verify after 3s
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF031A32)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              
              // Icon Area
              Center(
                child: _buildIcon(),
              ),
              const SizedBox(height: 32),
              
              // Title
              Text(
                _getTitle(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF031A32),
                ),
              ),
              const SizedBox(height: 16),
              
              // Subtitle
              Text(
                _getSubtitle(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
              
              const Spacer(),
              
              // Button (only for verified or rejected)
              if (_currentStatus != KycStatus.pending) ...[
                ElevatedButton(
                  onPressed: () {
                    if (_currentStatus == KycStatus.verified) {
                      // Navigate to dashboard or pop all the way back
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    } else if (_currentStatus == KycStatus.rejected) {
                      // Pop back to KYC submission screen to try again
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1865F2), // Bright blue
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _currentStatus == KycStatus.verified ? 'Continue' : 'Try Again',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    switch (_currentStatus) {
      case KycStatus.pending:
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            shape: BoxShape.circle,
          ),
          child: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1865F2)),
            strokeWidth: 4,
          ),
        );
      case KycStatus.verified:
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.verified_user,
            color: Color(0xFF00C853),
            size: 64,
          ),
        );
      case KycStatus.rejected:
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFFFEBEE),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.error_outline,
            color: Colors.redAccent,
            size: 64,
          ),
        );
    }
  }

  String _getTitle() {
    switch (_currentStatus) {
      case KycStatus.pending:
        return 'KYC Verification';
      case KycStatus.verified:
        return 'Identity Verified';
      case KycStatus.rejected:
        return 'Verification Failed';
    }
  }

  String _getSubtitle() {
    switch (_currentStatus) {
      case KycStatus.pending:
        return 'Verification in progress\n\nWe\'ll notify you when\nverification is complete.';
      case KycStatus.verified:
        return 'Your identity has been\nsuccessfully verified.';
      case KycStatus.rejected:
        return 'We couldn\'t verify\nyour documents.\n\nReason:\nDocument could not be verified.';
    }
  }
}
