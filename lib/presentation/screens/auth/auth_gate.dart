import 'package:fitquest/domain/repositories/auth_repository.dart';
import 'package:fitquest/presentation/screens/auth/login_screen.dart';
import 'package:fitquest/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = Provider.of<AuthRepository>(context, listen: true);
    return StreamBuilder(
      stream: authRepository.getUserStream().asStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
