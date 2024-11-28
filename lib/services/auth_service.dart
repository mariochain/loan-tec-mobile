import 'package:dio/dio.dart';
import 'package:materials_loan_lab/services/config/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio = ApiClient().dio;

  Future<Map<String, dynamic>> login(
      String controlNumber, String password) async {
    try {
      Response response = await _dio.post('/auth/login', data: {
        'controlNumber': controlNumber,
        'password': password,
      });

      if (response.statusCode == 201) {
        // Guarda el token en SharedPreferences
        final String token = response.data['data']['token'];
        await _saveToken(token);

        return response.data;
      } else {
        return {
          'status': 'error',
          'message': 'Error en la autenticación',
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': e.toString(),
      };
    }
  }

  Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    print('Token guardado: $token');
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');
    print('Sesión cerrada y token eliminado');
  }
}
