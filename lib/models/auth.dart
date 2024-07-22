import 'dart:async';

import 'package:dams_cash/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  List<User> get users => _users;
  List<User> _users = [
   
  ];

  Future<http.Response> fetchUser () async {
    final response = await http.get(Uri.parse('https://script.google.com/macros/s/AKfycby6zQmuoUdNFnDjmaSMK1xg1-7c8m5cPTY0GD6C2ZDbsVX37kO5xEct8wSAs0BrEqqg/exec'));
    if (response.statusCode == 200) {
      _users.clear();
      final List<dynamic> users = jsonDecode(response.body);
      for (var user in users) {
        _users.add(User.fromJson(user));
        notifyListeners();
      }
      return response;
    } else {
      throw Exception('Failed to load users');
    }
  }



  User _currentUser = User(id:0 ,name: '', email: '', password: '', isAdmin: false);
  User get currentUser => _currentUser;

  void setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void register(User user) {
    _users.add(user);
    notifyListeners();
  }
  
  Future<http.Response> postUser (User user) async {
    final response = await http.post(
      Uri.parse('https://script.google.com/macros/s/AKfycbzRWbzaRo-OvulCJMCiORNsCLJOwnEA-ddA37s-cYry3jJ-n7BSrbsLkb7d-oB9aQwE/exec'), 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
    return response;
  }

  bool loginWithEmail(String email, String password) {
    User? user = _users.firstWhere((user) => user.email == email && user.password == password, orElse: () => User(id : 0, name: '', email: '', password: '', isAdmin: false));
    if (user.name != '') {
      setCurrentUser(user);
      login();
      return true;
    }
    return false;
  }

  void logoutUser() {
    setCurrentUser(User(id: 0, name: '', email: '', password: '', isAdmin: false));
    logout();
  }
  
}