import 'package:flutter/material.dart';
import 'package:materials_loan_lab/models/loan_material_model.dart';
import '../models/loan_model.dart';

class LoanHistoryViewModel extends ChangeNotifier {
  List<Loan> loanHistory = [];
  bool isLoading = false;

  LoanHistoryViewModel() {
    fetchLoanHistory(); // Asegúrate de llamar a fetchLoanHistory aquí
  }

  // Simulación de datos hardcodeados con un préstamo para cada estado
  Future<void> fetchLoanHistory() async {
    isLoading = true;
    notifyListeners();

    // Simulando una espera como si fuera una llamada a una API
    await Future.delayed(const Duration(seconds: 2));

    // Datos hardcodeados de ejemplo para cada tipo de estado
    loanHistory = [
      Loan(
        id: 1,
        loanDate: DateTime(2024, 10, 1),
        dueDate: DateTime(2024, 10, 15),
        status: "Por Entregar",
        quantityLoaned: 10,
        quantityDelivered: 0,
        materials: [
          LoanMaterialItem(name: "Material 1", quantity: 5, delivered: false),
          LoanMaterialItem(name: "Material 2", quantity: 5, delivered: false),
        ],
      ),
      Loan(
        id: 2,
        loanDate: DateTime(2024, 9, 25),
        dueDate: DateTime(2024, 10, 5),
        status: "En tiempo",
        quantityLoaned: 5,
        quantityDelivered: 3,
        materials: [
          LoanMaterialItem(name: "Material 1", quantity: 2, delivered: true),
          LoanMaterialItem(name: "Material 2", quantity: 3, delivered: false),
        ],
      ),
      Loan(
        id: 3,
        loanDate: DateTime(2024, 9, 10),
        dueDate: DateTime(2024, 9, 20),
        status: "Entregado Parcial",
        quantityLoaned: 8,
        quantityDelivered: 4,
        materials: [
          LoanMaterialItem(name: "Material 3", quantity: 4, delivered: true),
          LoanMaterialItem(name: "Material 4", quantity: 4, delivered: false),
        ],
      ),
      Loan(
        id: 4,
        loanDate: DateTime(2024, 8, 15),
        dueDate: DateTime(2024, 9, 1),
        status: "Fuera de Tiempo",
        quantityLoaned: 6,
        quantityDelivered: 2,
        materials: [
          LoanMaterialItem(name: "Material 5", quantity: 3, delivered: false),
          LoanMaterialItem(name: "Material 6", quantity: 3, delivered: true),
        ],
      ),
      Loan(
        id: 5,
        loanDate: DateTime(2024, 7, 20),
        dueDate: DateTime(2024, 8, 5),
        status: "Entregado",
        quantityLoaned: 4,
        quantityDelivered: 4,
        materials: [
          LoanMaterialItem(name: "Material 7", quantity: 2, delivered: true),
          LoanMaterialItem(name: "Material 8", quantity: 2, delivered: true),
        ],
      ),
      Loan(
        id: 6,
        loanDate: DateTime(2024, 7, 5),
        dueDate: DateTime(2024, 7, 15),
        status: "Cancelado",
        quantityLoaned: 3,
        quantityDelivered: 0,
        materials: [
          LoanMaterialItem(name: "Material 9", quantity: 3, delivered: false),
        ],
      ),
    ];

    // ignore: avoid_print
    print("Historial de préstamos cargado: $loanHistory");

    isLoading = false;
    notifyListeners();
  }

  // Método para obtener el color basado en el estado del préstamo
  Color getStatusColor(String status) {
    switch (status) {
      case "Por Entregar":
        return Colors.green;
      case "En tiempo":
        return Colors.yellow;
      case "Entregado Parcial":
        return Colors.orange;
      case "Fuera de Tiempo":
        return Colors.red;
      case "Entregado":
        return Colors.blue;
      case "Cancelado":
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
