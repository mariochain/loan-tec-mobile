import 'package:flutter/material.dart';
import 'package:materials_loan_lab/viewmodels/cart_viewmodel.dart';
import 'package:materials_loan_lab/viewmodels/request_loan_viewmodel.dart';
import 'package:materials_loan_lab/widgets/cart_icon.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String title;

  const AppScaffold({
    super.key,
    required this.body,
    required this.title,
  });

  void _logout(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).logout(context);
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(title),
        ),
        actions: title != 'Login'
            ? [
                Consumer<RequestLoanViewModel>(
                  builder: (context, viewModel, child) {
                    return Stack(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.shopping_cart),
                          onPressed: () {
                            Navigator.pushNamed(context, '/cart');
                          },
                        ),
                        if (viewModel.cartTotalItems > 0)
                          Positioned(
                            right: 8,
                            top: 8,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.red,
                              child: Text(
                                '${viewModel.cartTotalItems}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ]
            : null,
      ),
      drawer: title != 'Login'
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    color: Colors.blue.shade900,
                    height: 80,
                    alignment: Alignment.center,
                    child: const Text(
                      'PrestaLab',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Inicio'),
                    onTap: () {
                      Navigator.pushNamed(context, '/home');
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Mi Perfil'),
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.assignment),
                    title: const Text('Solicitar Préstamo'),
                    onTap: () {
                      Navigator.pushNamed(context, '/request-loan');
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.history),
                    title: const Text('Mis Préstamos'),
                    onTap: () {
                      Navigator.pushNamed(context, '/loan-history');
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Cerrar Sesión'),
                    onTap: () => _logout(context),
                  ),
                  const Divider(),
                ],
              ),
            )
          : null,
      body: body,
    );
  }
}
