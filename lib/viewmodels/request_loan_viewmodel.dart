import 'package:flutter/material.dart';
import '../models/material_model.dart';
import '../services/material_service.dart';

class RequestLoanViewModel extends ChangeNotifier {
  final MaterialsService _materialsService = MaterialsService();

  List<MaterialItem> _allMaterials = [];
  List<MaterialItem> _filteredMaterials = [];
  Map<String, int> _selectedQuantities = {};
  Map<String, int> _cart = {};
  String _selectedCategory = 'Todas';
  String _searchQuery = '';
  List<String> _categories = ['Todas'];
  bool _loading = false;
  bool _initialized = false;

  // Getters
  List<MaterialItem> get filteredMaterials => _filteredMaterials;
  String get selectedCategory => _selectedCategory;
  List<String> get categories => _categories;
  bool get loading => _loading;
  int getSelectedQuantity(String idMaterial) =>
      _selectedQuantities[idMaterial] ?? 0;

  Map<String, int> get cart => _cart;
  int get cartTotalItems => _cart.length;

  // Load materials once during the session
  Future<void> loadMaterials() async {
    if (_initialized) return;
    _loading = true;
    notifyListeners();

    try {
      final materials = await _materialsService.fetchMaterials();
      _allMaterials = materials;
      _filteredMaterials = materials;
      _categories = [
        'Todas',
        ...materials.map((m) => m.categoryName).toSet().toList()
      ];
      _selectedQuantities = {
        for (var material in materials) material.idMaterial: 0
      };
      _initialized = true;
      notifyListeners();
    } catch (e) {
      print('Error al cargar materiales: $e');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // Filters
  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredMaterials = _allMaterials.where((material) {
      final matchesCategory = _selectedCategory == 'Todas' ||
          material.categoryName == _selectedCategory;
      final matchesSearch =
          material.name.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
    notifyListeners();
  }

  // Increment and decrement quantities
  void incrementQuantity(String idMaterial, int stock) {
    if (_selectedQuantities[idMaterial]! < stock) {
      _selectedQuantities[idMaterial] = _selectedQuantities[idMaterial]! + 1;

      // Update cart
      _updateCart(idMaterial, _selectedQuantities[idMaterial]!);
      notifyListeners();
    }
  }

  void decrementQuantity(String idMaterial) {
    if (_selectedQuantities[idMaterial]! > 0) {
      _selectedQuantities[idMaterial] = _selectedQuantities[idMaterial]! - 1;

      // Update cart
      _updateCart(idMaterial, _selectedQuantities[idMaterial]!);
      notifyListeners();
    }
  }

  // Update cart
  void _updateCart(String idMaterial, int quantity) {
    if (quantity > 0) {
      _cart[idMaterial] = quantity;
    } else {
      _cart.remove(idMaterial);
    }
    notifyListeners();
  }

  // Remove material from cart
  void removeFromCart(String idMaterial) {
    _selectedQuantities[idMaterial] = 0; // Set quantity to 0
    _cart.remove(idMaterial); // Remove from cart
    notifyListeners();
  }

  // Send cart to backend
  Future<void> sendCart(BuildContext context) async {
    if (_cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El carrito está vacío'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final materialLoan = _cart.entries.map((entry) {
        return {
          "idMaterial": entry.key,
          "quantity": entry.value,
        };
      }).toList();

      final requestPayload = {
        "materialLoan": materialLoan,
      };

      // Simulating sending data to backend
      final response = await _materialsService.sendLoanRequest(requestPayload);

      if (response) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Solicitud enviada exitosamente'),
            backgroundColor: Colors.green,
          ),
        );

        // Reset the cart after successful submission
        _cart.clear();
        _selectedQuantities = {
          for (var material in _allMaterials) material.idMaterial: 0
        };
        notifyListeners();
      } else {
        throw Exception('Error al enviar la solicitud');
      }
    } catch (e) {
      print('Error al enviar solicitud: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo enviar la solicitud'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
