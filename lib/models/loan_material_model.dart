class LoanMaterialItem {
  final String name;
  final int quantity;
  final bool delivered;

  LoanMaterialItem({
    required this.name,
    required this.quantity,
    required this.delivered,
  });

  factory LoanMaterialItem.fromJson(Map<String, dynamic> json) {
    return LoanMaterialItem(
      name: json['name'],
      quantity: json['quantity'],
      delivered: json['delivered'],
    );
  }
}
