import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import 'package:materials_loan_lab/services/auth_service.dart';
import 'package:provider/provider.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController controlNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final logoHeight = screenHeight * 0.3;
    final logoWidth = screenWidth * 0.6;

    final inputWidth = screenWidth * 0.8;
    final buttonWidth = screenWidth * 0.4;

    return Scaffold(
      body: Container(
        decoration: backgroundGradient(),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sizeLogo(logoHeight, logoWidth),
                space(),
                space(),
                inputControlNumber(inputWidth),
                space(),
                inputPassword(inputWidth),
                space(),
                SizedBox(
                  width: buttonWidth,
                  child: Consumer<LoginViewModel>(
                    builder: (context, loginVM, child) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () async {
                          await loginVM.login(
                            controlNumberController.text,
                            passwordController.text,
                            context,
                          );
                          if (loginVM.errorMessage == null) {
                            final authService = AuthService();
                            final token = await authService.getToken();
                            print('Token obtenido: $token');
                            // Navega al Home si no hay errores
                            Navigator.pushReplacementNamed(context, '/home');
                          } else {
                            // Muestra el mensaje de error en un SnackBar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(loginVM.errorMessage!),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.red,
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          }
                        },
                        child: loginVM.loading
                            ? const CircularProgressIndicator()
                            : const Text('Ingresar'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox inputControlNumber(double inputWidth) {
    return SizedBox(
      width: inputWidth,
      child: TextField(
        style: styleInputFont(),
        controller: controlNumberController,
        decoration: inputDecoration('Número de Control'),
      ),
    );
  }

  SizedBox inputPassword(double inputWidth) {
    return SizedBox(
      width: inputWidth,
      child: TextField(
        style: styleInputFont(),
        controller: passwordController,
        obscureText: !_isPasswordVisible,
        decoration: inputDecoration('Contraseña').copyWith(
          suffixIcon: passwordVisibility(
            isVisible: _isPasswordVisible,
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
        ),
      ),
    );
  }

  IconButton passwordVisibility({
    required bool isVisible,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      icon: Icon(
        isVisible ? Icons.visibility : Icons.visibility_off,
        color: Colors.white,
      ),
      onPressed: onPressed,
    );
  }
}

SizedBox space({double height = 20}) {
  return SizedBox(height: height);
}

BoxDecoration backgroundGradient() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Colors.blue[50]!,
        Colors.blue[700]!,
      ],
    ),
  );
}

DropShadowImage sizeLogo(double logoHeight, double logoWidth) {
  return DropShadowImage(
    offset: const Offset(10, 10),
    scale: 1,
    blurRadius: 10,
    borderRadius: 50,
    image: Image.asset(
      'assets/buffalo.jpeg',
      height: logoHeight,
      width: logoWidth,
    ),
  );
}

InputDecoration inputDecoration(String labelText) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: const TextStyle(color: Colors.white),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 3.0),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 4.0),
    ),
  );
}

TextStyle styleInputFont() {
  return const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
