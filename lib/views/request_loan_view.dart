import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/request_loan_viewmodel.dart';
import '../app_scaffold.dart';

class RequestLoanView extends StatefulWidget {
  const RequestLoanView({super.key});

  @override
  State<RequestLoanView> createState() => _RequestLoanViewState();
}

class _RequestLoanViewState extends State<RequestLoanView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RequestLoanViewModel>(context, listen: false).loadMaterials();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Solicitar Préstamo',
      body: Consumer<RequestLoanViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Campo de búsqueda
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Buscar material',
                    suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) => viewModel.setSearchQuery(value),
                ),
                const SizedBox(height: 16),
                // Menú desplegable de categorías
                DropdownButton<String>(
                  isExpanded: true,
                  value: viewModel.selectedCategory,
                  items: viewModel.categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      viewModel.setSelectedCategory(value);
                    }
                  },
                ),
                const SizedBox(height: 16),
                // Lista de materiales filtrados
                Expanded(
                  child: viewModel.filteredMaterials.isEmpty
                      ? const Center(
                          child: Text('No se encontraron materiales'),
                        )
                      : ListView.builder(
                          itemCount: viewModel.filteredMaterials.length,
                          itemBuilder: (context, index) {
                            final material = viewModel.filteredMaterials[index];
                            final currentQuantity = viewModel
                                .getSelectedQuantity(material.idMaterial);

                            return ListTile(
                              leading: Image.network(
                                material.urlImage,
                                width: 50,
                                height: 50,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image),
                              ),
                              title: Text(material.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(material.description),
                                  Text('Stock: ${material.stock}'),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            viewModel.decrementQuantity(
                                                material.idMaterial),
                                        icon: const Icon(Icons.remove),
                                      ),
                                      Text('$currentQuantity'),
                                      IconButton(
                                        onPressed: () =>
                                            viewModel.incrementQuantity(
                                                material.idMaterial,
                                                material.stock),
                                        icon: const Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
