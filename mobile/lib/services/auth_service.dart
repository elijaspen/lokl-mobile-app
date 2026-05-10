import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthService extends ChangeNotifier {
  final String baseUrl = "http://127.0.0.1:8000/api";
  
  UserModel? _user;
  String? _token;
  bool _isInitialized = false;
  bool _showRegister = false;

  UserModel? get user => _user;
  String? get token => _token;
  bool get isAuthenticated => _token != null;
  bool get isInitialized => _isInitialized;
  bool get showRegister => _showRegister;

  void setRegistrationView(bool show) {
    _showRegister = show;
    notifyListeners();
  }

  AuthService() {
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
    final userData = prefs.getString('user_data');
    
    if (userData != null) {
      _user = UserModel.fromJson(jsonDecode(userData));
    }
    
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> register(String name, String email, String password, UserRole role) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'role': role == UserRole.rider ? 'rider' : 'customer',
      }),
    );
if (response.statusCode == 200) {
  final data = jsonDecode(response.body);
  await _saveSession(data['access_token'], data['user']);
} else {
  throw Exception(jsonDecode(response.body)['message'] ?? 'Failed to register');
}
}

Future<void> login(String email, String password) async {
final response = await http.post(
  Uri.parse('$baseUrl/login'),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode({
    'email': email,
    'password': password,
  }),
);

if (response.statusCode == 200) {
  final data = jsonDecode(response.body);
  await _saveSession(data['access_token'], data['user']);
} else {
  throw Exception(jsonDecode(response.body)['message'] ?? 'Failed to login');
}
}
  Future<void> _saveSession(String token, Map<String, dynamic> userJson) async {
    final prefs = await SharedPreferences.getInstance();
    _token = token;
    _user = UserModel.fromJson(userJson);
    
    await prefs.setString('auth_token', token);
    await prefs.setString('user_data', jsonEncode(userJson));
    await prefs.setBool('has_logged_in_once', true);
    
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_data');
    
    _user = null;
    _token = null;
    notifyListeners();
  }

  Future<bool> hasSeenLandingOnce() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('has_logged_in_once') ?? false;
  }
}
