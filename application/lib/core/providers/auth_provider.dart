import 'package:flutter/foundation.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String nationalIdOrPassport;
  final bool isKycVerified;
  bool selfExcluded;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.nationalIdOrPassport,
    this.isKycVerified = false,
    this.selfExcluded = false,
  });

  UserModel copyWith({
    bool? isKycVerified,
    bool? selfExcluded,
  }) {
    return UserModel(
      id: id,
      name: name,
      email: email,
      phone: phone,
      nationalIdOrPassport: nationalIdOrPassport,
      isKycVerified: isKycVerified ?? this.isKycVerified,
      selfExcluded: selfExcluded ?? this.selfExcluded,
    );
  }
}

class AuthProvider with ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  bool get isLoading => _isLoading;

  // Mock Login
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2)); // Simulate network request

    if (email.isNotEmpty && password.isNotEmpty) {
      _currentUser = UserModel(
        id: 'user_123',
        name: 'John Doe',
        email: email,
        phone: '+1234567890',
        nationalIdOrPassport: 'A1234567',
        isKycVerified: true,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  // Mock Register
  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String nationalId,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2)); // Simulate network request

    _currentUser = UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      phone: phone,
      nationalIdOrPassport: nationalId,
      isKycVerified: false, // Requires KYC approval
    );

    _isLoading = false;
    notifyListeners();
    return true;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  void toggleSelfExclusion() {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(selfExcluded: !_currentUser!.selfExcluded);
      notifyListeners();
    }
  }

  void verifyKyc() {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(isKycVerified: true);
      notifyListeners();
    }
  }
}
