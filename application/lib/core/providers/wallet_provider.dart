import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String type; // 'deposit', 'withdrawal', 'ticket_purchase', 'prize_win'
  final double amount;
  final DateTime date;

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
  });
}

class WalletProvider with ChangeNotifier {
  double _balance = 65.00; // Start with some dummy balance
  final List<Transaction> _transactions = [
    Transaction(id: 'tx_1', type: 'deposit', amount: 100.0, date: DateTime.now().subtract(const Duration(days: 2))),
    Transaction(id: 'tx_2', type: 'ticket_purchase', amount: -35.0, date: DateTime.now().subtract(const Duration(days: 1))),
  ];

  double get balance => _balance;
  List<Transaction> get transactions => _transactions;

  Future<bool> deposit(double amount) async {
    if (amount <= 0) return false;
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    _balance += amount;
    _transactions.insert(0, Transaction(
      id: 'tx_${DateTime.now().millisecondsSinceEpoch}',
      type: 'deposit',
      amount: amount,
      date: DateTime.now(),
    ));
    
    notifyListeners();
    return true;
  }

  Future<bool> withdraw(double amount) async {
    if (amount <= 0 || amount > _balance) return false;
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    _balance -= amount;
    _transactions.insert(0, Transaction(
      id: 'tx_${DateTime.now().millisecondsSinceEpoch}',
      type: 'withdrawal',
      amount: -amount,
      date: DateTime.now(),
    ));
    
    notifyListeners();
    return true;
  }

  Future<bool> purchaseTicket(double cost) async {
    if (cost <= 0 || cost > _balance) return false;
    
    _balance -= cost;
    _transactions.insert(0, Transaction(
      id: 'tx_${DateTime.now().millisecondsSinceEpoch}',
      type: 'ticket_purchase',
      amount: -cost,
      date: DateTime.now(),
    ));
    
    notifyListeners();
    return true;
  }

  void awardPrize(double amount) {
    if (amount <= 0) return;
    
    _balance += amount;
    _transactions.insert(0, Transaction(
      id: 'tx_${DateTime.now().millisecondsSinceEpoch}',
      type: 'prize_win',
      amount: amount,
      date: DateTime.now(),
    ));
    
    notifyListeners();
  }
}
