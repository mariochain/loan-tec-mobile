import 'package:dio/dio.dart';
import '../models/material_model.dart';
import 'config/api_client.dart';

class MaterialsService {
  final Dio _dio = ApiClient().dio;

  Future<List<MaterialItem>> fetchMaterials() async {
    try {
      final response = await _dio.get('/materials');
      print('Datos crudos del servidor: ${response.data}');
      if (response.statusCode == 200) {
        final List<dynamic> materialsJson = response.data;
        print('Datos procesados: $materialsJson');
        return materialsJson
            .map((json) => MaterialItem.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Error al obtener los materiales: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en fetchMaterials: $e');
      throw Exception('Error en la solicitud de materiales: $e');
    }
  }

  // Send loan request
  Future<bool> sendLoanRequest(Map<String, dynamic> requestPayload) async {
    try {
      print('aqui esta el payload para enviar ${requestPayload}');
      final response = await _dio.post('/loans', data: requestPayload);
      print('aqui esta el response ${response}');

      if (response.statusCode == 201) {
        // La solicitud fue creada exitosamente
        return true;
      } else {
        print('Error en la solicitud: ${response.data}');
        return false;
      }
    } catch (e) {
      print('Error en sendLoanRequest: $e');
      return false;
    }
  }
}
