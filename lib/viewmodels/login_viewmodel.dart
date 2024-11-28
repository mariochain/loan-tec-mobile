import 'package:flutter/material.dart';
import 'package:materials_loan_lab/models/usuario_model.dart';
import 'package:materials_loan_lab/providers/auth_provider.dart';
import 'package:materials_loan_lab/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  Usuario? _usuario;
  Usuario? get usuario => _usuario;

  bool _loading = false;
  bool get loading => _loading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> login(
    String controlNumber,
    String password,
    BuildContext context,
  ) async {
    _loading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _authService.login(controlNumber, password);

      if (response['status'] == 200) {
        try {
          _usuario = Usuario.fromJson(response['data']['user']);
          print('Usuario autenticado: ${_usuario?.name}');

          _loading = false;
          final authProvider =
              Provider.of<AuthProvider>(context, listen: false);
          authProvider.authenticate(_usuario!);
          notifyListeners();
        } catch (e) {
          _errorMessage = 'Error al procesar los datos del usuario';
          print('Error en el parsing del usuario: $e');
          _loading = false;
          notifyListeners();
        }
      } else {
        _errorMessage = response['message'] ?? 'Credenciales incorrectas';
        print('Error en autenticación: ${response['message']}');
        _loading = false;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'No se pudo conectar al servidor';
      print('Error en conexión: $e');
      _loading = false;
      notifyListeners();
    }
  }

  void logout() {
    _usuario = null;
    notifyListeners();
  }
}
