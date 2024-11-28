class MaterialItem {
  final String idMaterial;
  final String name;
  final String description;
  final int stock; // Este es el inventario disponible y no se modifica
  final String urlImage;
  final String categoryName;
  int requestedQuantity; // Nueva propiedad mutable

  MaterialItem({
    required this.idMaterial,
    required this.name,
    required this.description,
    required this.stock,
    required this.urlImage,
    required this.categoryName,
    this.requestedQuantity = 0, // Por defecto es 0
  });

  factory MaterialItem.fromJson(Map<String, dynamic> json) {
    return MaterialItem(
      idMaterial: json['idMaterial'],
      name: json['name'],
      description: json['description'],
      stock: json['stock'],
      urlImage: json['urlImage'],
      categoryName: json['categoryName'],
    );
  }
}
