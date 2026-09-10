import 'package:flutter/foundation.dart';
import 'dart:math';
import 'package:application/core/providers/wallet_provider.dart';

class TicketModel {
  final String id;
  final String number; // 11-digit number
  final String drawId;
  final DateTime purchaseDate;
  final double amount;
  String status; // 'Active', 'Won', 'Lost'

  TicketModel({
    required this.id,
    required this.number,
    required this.drawId,
    required this.purchaseDate,
    required this.amount,
    this.status = 'Active',
  });
}

class DrawModel {
  final String id;
  final DateTime drawDate;
  final String winningNumber;
  final bool isCompleted;

  DrawModel({
    required this.id,
    required this.drawDate,
    required this.winningNumber,
    this.isCompleted = false,
  });
}

class LotteryProvider with ChangeNotifier {
  final List<TicketModel> _tickets = [];
  DrawModel? _upcomingDraw;
  final List<DrawModel> _pastDraws = [];
  
  List<TicketModel> get tickets => _tickets;
  DrawModel? get upcomingDraw => _upcomingDraw;
  List<DrawModel> get pastDraws => _pastDraws;

  LotteryProvider() {
    _initDraws();
  }

  void _initDraws() {
    // Setup an upcoming draw 24 hours from now
    _upcomingDraw = DrawModel(
      id: 'draw_${Random().nextInt(9000) + 1000}',
      drawDate: DateTime.now().add(const Duration(hours: 24)),
      winningNumber: '',
    );
    
    // Add some past draws
    _pastDraws.add(DrawModel(
      id: 'draw_past_1',
      drawDate: DateTime.now().subtract(const Duration(days: 1)),
      winningNumber: _generateRandom11Digit(),
      isCompleted: true,
    ));
    
    notifyListeners();
  }

  String _generateRandom11Digit() {
    final random = Random();
    String number = '';
    for (int i = 0; i < 11; i++) {
      number += random.nextInt(10).toString();
    }
    return number;
  }

  Future<bool> purchaseTicket(WalletProvider walletProvider) async {
    const double ticketCost = 10.0;
    
    bool success = await walletProvider.purchaseTicket(ticketCost);
    if (success) {
      _tickets.insert(0, TicketModel(
        id: 'ticket_${DateTime.now().millisecondsSinceEpoch}',
        number: _generateRandom11Digit(),
        drawId: _upcomingDraw?.id ?? 'unknown',
        purchaseDate: DateTime.now(),
        amount: ticketCost,
      ));
      notifyListeners();
      return true;
    }
    return false;
  }

  void simulateDrawExecution(WalletProvider walletProvider) {
    if (_upcomingDraw == null) return;

    final winningNumber = _generateRandom11Digit();
    final completedDraw = DrawModel(
      id: _upcomingDraw!.id,
      drawDate: _upcomingDraw!.drawDate,
      winningNumber: winningNumber,
      isCompleted: true,
    );
    
    _pastDraws.insert(0, completedDraw);
    
    // Check if any active tickets won (Simulated logic: 10% chance to win something for mock purposes)
    final random = Random();
    for (var ticket in _tickets.where((t) => t.status == 'Active')) {
      if (ticket.drawId == completedDraw.id) {
        if (random.nextDouble() < 0.1) { 
          ticket.status = 'Won';
          walletProvider.awardPrize(100.0); // Award $100
        } else {
          ticket.status = 'Lost';
        }
      }
    }

    // Setup next draw
    _upcomingDraw = DrawModel(
      id: 'draw_${Random().nextInt(9000) + 1000}',
      drawDate: DateTime.now().add(const Duration(hours: 24)),
      winningNumber: '',
    );

    notifyListeners();
  }
}
