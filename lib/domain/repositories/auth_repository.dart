
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitquest/data/models/AuthResponse.dart';
import '../../data/datasources/remote/firebase_service.dart';

abstract class AuthRepository {
  User? getCurrentUser();
  Future<User?> getUserStream();
  Future<AuthResponse> signIn({required String email, required String password});
  Future<AuthResponse> register({required String email, required String password});
  Future<void> signOut();
  Future<bool> isUserSignedIn();
  Future<bool> isOnline();
}

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseService _firebaseService;

  AuthRepositoryImpl(this._firebaseService);

  @override
  User? getCurrentUser() {
    return _firebaseService.getCurrentUser();
  }

  @override
  Future<User?> getUserStream(){
    return _firebaseService.userStream.first;
  }

  @override
  Future<AuthResponse> register({required String email, required String password}) async {
    return await _firebaseService.registerUser(email: email, password: password);
  }

  @override
  Future<AuthResponse> signIn({required String email, required String password}) async {
    return await _firebaseService.signIn(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await _firebaseService.signOut();
  }

  @override
  Future<bool> isUserSignedIn() async {
    final user = getCurrentUser();
    return user != null;
  }

  @override
  Future<bool> isOnline() async => true;
}