import 'package:flutter/material.dart';
import 'package:materials_loan_lab/providers/auth_provider.dart';
import 'package:materials_loan_lab/router/protected_route.dart';
import 'package:materials_loan_lab/viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';
import 'viewmodels/cart_viewmodel.dart';
import 'viewmodels/request_loan_viewmodel.dart';
import 'viewmodels/loan_history_viewmodel.dart';
import 'views/login_view.dart';
import 'views/home_view.dart';
import 'views/request_loan_view.dart';
import 'views/cart_view.dart';
import 'views/loan_history_view.dart';
import 'views/profile_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => RequestLoanViewModel()),
        ChangeNotifierProvider(create: (_) => LoanHistoryViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginView(),
          '/home': (context) => const ProtectedRoute(child: HomeView()),
          '/request-loan': (context) =>
              const ProtectedRoute(child: RequestLoanView()),
          '/cart': (context) => ProtectedRoute(child: CartView()),
          '/loan-history': (context) =>
              const ProtectedRoute(child: LoanHistoryView()),
          '/profile': (context) => const ProtectedRoute(
                child: ProfileView(),
              ),
        },
        home: const LoginView(),
      ),
    );
  }
}
