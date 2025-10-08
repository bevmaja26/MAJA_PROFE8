import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/user_model.dart';
import '../services/storage_service.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;

  Future<void> checkAuthStatus() async {
    _isLoading = true;
    notifyListeners();

    final userData = await StorageService.getUser();
    if (userData != null) {
      _currentUser = User.fromJson(jsonDecode(userData));
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      final users = await StorageService.getUsers();

      final userJson = users.firstWhere(
        (u) {
          final user = jsonDecode(u);
          return user['email'] == email && user['password'] == password;
        },
        orElse: () => '',
      );

      if (userJson.isEmpty) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final userData = jsonDecode(userJson);
      _currentUser = User.fromJson(userData);
      await StorageService.saveUser(jsonEncode(_currentUser!.toJson()));

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required UserRole role,
    String? phone,
    String? address,
    String? profileImageUrl,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));

      final newUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        role: role,
        phone: phone,
        address: address,
        profileImageUrl: profileImageUrl,
        createdAt: DateTime.now(),
      );

      final userWithPassword = {
        ...newUser.toJson(),
        'password': password,
      };

      await StorageService.addUser(jsonEncode(userWithPassword));

      _currentUser = newUser;
      await StorageService.saveUser(jsonEncode(newUser.toJson()));

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    await StorageService.clearUser();
    notifyListeners();
  }

  Future<void> updateProfile({
    String? name,
    String? phone,
    String? address,
    String? profileImageUrl,
  }) async {
    if (_currentUser == null) return;

    _currentUser = User(
      id: _currentUser!.id,
      name: name ?? _currentUser!.name,
      email: _currentUser!.email,
      role: _currentUser!.role,
      phone: phone ?? _currentUser!.phone,
      address: address ?? _currentUser!.address,
      profileImageUrl: profileImageUrl ?? _currentUser!.profileImageUrl,
      createdAt: _currentUser!.createdAt,
    );

    await StorageService.saveUser(jsonEncode(_currentUser!.toJson()));
    notifyListeners();
  }
}
