import 'package:fitquest/core/utils/dialog_utils.dart';
import 'package:fitquest/presentation/widgets/shared/auth/auth_button.dart';
import 'package:fitquest/presentation/widgets/shared/auth/auth_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/repositories/auth_repository.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "login";
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authRepository = Provider.of<AuthRepository>(context);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Icon(
                  Icons.fitness_center,
                  size: 100,
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Welcome back. You have been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                AuthTextfield(
                  hintText: 'user@example.com',
                  obscureText: false,
                  controller: emailController,
                ),
                const SizedBox(
                  height: 25,
                ),
                AuthTextfield(
                  hintText: 'password',
                  obscureText: true,
                  controller: passwordController,
                ),
                AuthButton(
                  onTap: () async {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      DialogUtils.showLoadingDialog(context);
                      final user = await authRepository.signIn(
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      emailController.clear();
                      passwordController.clear();
                      Navigator.pushReplacementNamed(context, '/homepage');
                                        } else {
                      DialogUtils.showAlertDialog(
                          context, 'Error', 'Please fill all fields.');
                      Navigator.pop(context);
                    }
                  },
                ),
                // or not a member, sign in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/signup');
                      },
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
