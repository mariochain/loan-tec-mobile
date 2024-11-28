import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../app_scaffold.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtén el AuthProvider para acceder al estado del usuario
    final authProvider = Provider.of<AuthProvider>(context);

    // Obtén el nombre del usuario autenticado
    final userName = authProvider.currentUser?.name ?? 'Invitado';

    return AppScaffold(
      title: 'Pantalla Principal',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '¡Bienvenido, \n',
                style: const TextStyle(
                  fontSize: 36,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: userName,
                    style: const TextStyle(
                      fontSize: 36,
                      color: Color.fromARGB(255, 7, 58, 99),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text: '!',
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/request-loan');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.assignment),
                    SizedBox(width: 10),
                    Text('Solicitar Préstamo'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/loan-history');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.history),
                    SizedBox(width: 10),
                    Text('Mis Préstamos'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
