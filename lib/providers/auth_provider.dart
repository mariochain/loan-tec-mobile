import 'package:flutter/material.dart';
import 'package:materials_loan_lab/models/usuario_model.dart';

class AuthProvider extends ChangeNotifier {
  Usuario? _currentUser;
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;
  Usuario? get currentUser => _currentUser;

  void authenticate(Usuario user) {
    _currentUser = user;
    _isAuthenticated = true;
    notifyListeners();
  }

  void logout(BuildContext context) {
    _currentUser = null;
    _isAuthenticated = false;
    notifyListeners();
    Navigator.pushReplacementNamed(context, '/login');
  }
}
