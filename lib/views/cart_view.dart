import 'package:flutter/material.dart';
import 'package:materials_loan_lab/models/material_model.dart';
import 'package:provider/provider.dart';
import '../viewmodels/request_loan_viewmodel.dart';
import '../app_scaffold.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AppScaffold(
      title: 'Carrito de Solicitud',
      body: Stack(
        children: [
          Consumer<RequestLoanViewModel>(
            builder: (context, viewModel, child) {
              final cartItems = viewModel.cart.entries
                  .where((entry) => entry.value > 0)
                  .map((entry) {
                final material = viewModel.filteredMaterials.firstWhere(
                  (material) => material.idMaterial == entry.key,
                  orElse: () => MaterialItem(
                    idMaterial: entry.key,
                    name: 'Desconocido',
                    description: 'No disponible',
                    stock: 0,
                    categoryName: '',
                    urlImage: '',
                  ),
                );
                return {
                  'material': material,
                  'quantity': entry.value,
                };
              }).toList();

              if (cartItems.isEmpty) {
                return const Center(
                  child: Text('El carrito está vacío'),
                );
              }

              return ListView.builder(
                padding:
                    const EdgeInsets.only(bottom: 80), // Espacio para el botón
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartItems[index];
                  final material = cartItem['material'] as MaterialItem;
                  final quantity = cartItem['quantity'] as int;

                  return Card(
                    margin: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: screenWidth *
                          0.05, // Margen horizontal para las cards
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Imagen del material
                          Align(
                            alignment: Alignment.center,
                            child: Image.network(
                              material.urlImage,
                              width: 80,
                              height: 80,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Contenido de texto
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  material.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  material.description,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Stock disponible: ${material.stock}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                // Botones de acción
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () =>
                                              viewModel.decrementQuantity(
                                                  material.idMaterial),
                                          icon: const Icon(Icons.remove),
                                        ),
                                        Text('$quantity'),
                                        IconButton(
                                          onPressed: () =>
                                              viewModel.incrementQuantity(
                                            material.idMaterial,
                                            material.stock,
                                          ),
                                          icon: const Icon(Icons.add),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () => viewModel
                                          .removeFromCart(material.idMaterial),
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          // Botón fijo en la parte inferior
          Positioned(
            bottom: 16,
            left: 32,
            right: 32,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // Invoca el método para enviar el carrito
                context.read<RequestLoanViewModel>().sendCart(context);
              },
              child: const Text(
                'Enviar Solicitud',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
