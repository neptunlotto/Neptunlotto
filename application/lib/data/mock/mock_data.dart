class MockData {
  static const user = {
    'name': 'Rajnikant',
    'email': 'demo@neptunlotto.com',
    'kycStatus': 'Verified',
    'walletBalance': 125.00,
  };

  static const tickets = [
    {
      'id': 'LOT-1001',
      'number': '58392017462',
      'draw': 'DRAW-1023',
      'amount': 10.00,
      'status': 'ACTIVE',
    },
    {
      'id': 'LOT-1002',
      'number': '92837461520',
      'draw': 'DRAW-1022',
      'amount': 10.00,
      'status': 'LOST',
    },
  ];

  static const winners = [
    '58392017462',
    '92837461520',
    '10482736591',
    '47281930564',
    '81726394015',
    '39281746520',
    '62019483751',
  ];

  static const transactions = [
    {
      'type': 'Prize',
      'amount': 100.00,
      'date': 'Today, 10:42 AM',
      'isPositive': true,
    },
    {
      'type': 'Ticket Purchase',
      'amount': 10.00,
      'date': 'Yesterday, 14:20 PM',
      'isPositive': false,
    },
    {
      'type': 'Ticket Purchase',
      'amount': 10.00,
      'date': '05 Sep 2026',
      'isPositive': false,
    },
    {
      'type': 'Deposit',
      'amount': 50.00,
      'date': '01 Sep 2026',
      'isPositive': true,
    },
  ];
}
