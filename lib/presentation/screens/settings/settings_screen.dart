import 'package:fitquest/core/utils/dialog_utils.dart';
import 'package:fitquest/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitquest/domain/repositories/auth_repository.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = Provider.of<AuthRepository>(context);
    final user = authRepository.getCurrentUser();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Signed in as: ${user?.email}'),
            CustomButton(
                onTap: () async {
                  try{
                    DialogUtils.showLoadingDialog(context);
                    await authRepository.signOut();
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/login');
                  }catch(e){
                    DialogUtils.showAlertDialog(context, 'Error', '$e');
                  }
                },
                textColor: Colors.white,
                backgroundColor: Colors.black,
                buttonText: 'Sign out')
          ],
        ),
      ),
    );
  }
}
