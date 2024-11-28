import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/cart_viewmodel.dart';

class MaterialCard extends StatefulWidget {
  final String materialName;
  final String description;
  final int availableQuantity;
  final String imageUrl;

  const MaterialCard({
    super.key,
    required this.materialName,
    required this.description,
    required this.availableQuantity,
    required this.imageUrl,
  });

  @override
  MaterialCardState createState() => MaterialCardState();
}

class MaterialCardState extends State<MaterialCard> {
  final TextEditingController quantityController = TextEditingController();

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Imagen o placeholder de imagen
          SizedBox(
            width: 80,
            height: 80,
            child: Image.network(
              widget.imageUrl,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.broken_image,
                color: Colors.grey[400],
                size: 40,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Información del material
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.materialName,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.description,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
                Text(
                  'Disponibilidad: ${widget.availableQuantity}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          // Input para la cantidad y botón de agregar
          Column(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: TextField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '0',
                  ),
                ),
              ),
              const SizedBox(height: 2),
              /* ElevatedButton(
                onPressed: () {
                  final quantity = int.tryParse(quantityController.text) ?? 1;
                  // Lógica para agregar el material al carrito con la cantidad ingresada
                  context
                      .read<CartViewModel>()
                      .addMaterial(widget.materialName, quantity);
                },
                child: const Text('Agregar'),
              ), */
            ],
          ),
        ],
      ),
    );
  }
}
