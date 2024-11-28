import 'package:flutter/material.dart';
import '../models/material_model.dart';

class CartViewModel extends ChangeNotifier {
  final Map<String, int> _selectedMaterials = {};

  void updateCart(String idMaterial, int quantity) {
    if (quantity > 0) {
      _selectedMaterials[idMaterial] = quantity;
    } else {
      _selectedMaterials.remove(idMaterial);
    }
    notifyListeners();
  }

  Map<String, int> get selectedMaterials => _selectedMaterials;

  int get totalItems => _selectedMaterials.length;
}
