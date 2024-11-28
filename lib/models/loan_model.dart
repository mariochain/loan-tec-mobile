import 'package:materials_loan_lab/models/loan_material_model.dart';

class Loan {
  final int id;
  final DateTime loanDate;
  final DateTime dueDate;
  final String status;
  final int quantityLoaned;
  final int quantityDelivered;
  final List<LoanMaterialItem> materials;

  Loan({
    required this.id,
    required this.loanDate,
    required this.dueDate,
    required this.status,
    required this.quantityLoaned,
    required this.quantityDelivered,
    required this.materials,
  });

  factory Loan.fromJson(Map<String, dynamic> json) {
    return Loan(
      id: json['id'],
      loanDate: DateTime.parse(json['loanDate']),
      dueDate: DateTime.parse(json['dueDate']),
      status: json['loanStatus'],
      quantityLoaned: json['quantityLoaned'],
      quantityDelivered: json['quantityDelivered'],
      materials: json['materials'] != null
          ? List<LoanMaterialItem>.from(json['materials']
              .map((materialJson) => LoanMaterialItem.fromJson(materialJson)))
          : [],
    );
  }
}
