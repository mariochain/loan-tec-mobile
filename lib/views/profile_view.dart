import 'package:flutter/material.dart';
import 'package:materials_loan_lab/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../app_scaffold.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return AppScaffold(
      title: 'Mi Perfil',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ícono de perfil
            user?.pictureProfile != null && user!.pictureProfile.isNotEmpty
                ? CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.pictureProfile),
                  )
                : const Icon(
                    Icons.person,
                    size: 100,
                    color: Colors.grey,
                  ),
            const SizedBox(height: 20),

            // Información del perfil
            if (user != null) ...[
              Text(
                'Nombre: ${user.name}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'No de Control: ${user.controlNumber}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Correo: ${user.email}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Carrera: ${user.degreeProgramName}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Semestre: ${user.semester}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
