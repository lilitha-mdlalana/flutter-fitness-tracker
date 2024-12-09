import 'package:firebase_auth/firebase_auth.dart';

class AuthResponse {
  final String username;
  final User? userDetails;
  final bool isAuthenticated;
  final String message;

  AuthResponse(
      {required this.username,
        this.userDetails,
        required this.isAuthenticated,
        required this.message});
}