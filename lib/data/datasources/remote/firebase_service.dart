import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitquest/data/models/AuthResponse.dart';
import 'package:fitquest/data/models/goal_model.dart';

import '../../models/workout_model.dart';

class FirebaseService {
  Future<bool> isOnline() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  get userStream => _auth.authStateChanges();

  Future<AuthResponse> signIn(
      {required String email, required String password}) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return AuthResponse(
          username: email,
          isAuthenticated: true,
          message: 'Login Success!',
          userDetails: user.user);
    } on FirebaseAuthException catch (e) {
      print("Failed to sign in user with Firebase: $e");
      return AuthResponse(
          username: email, isAuthenticated: false, message: e.message!);
    }
  }

  Future<AuthResponse> registerUser(
      {required String email, required String password}) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return AuthResponse(
          username: email,
          isAuthenticated: true,
          message: 'Registration success!',
          userDetails: user.user);
    } on FirebaseAuthException catch (e) {
      print("Failed to register user with Firebase: $e");
      return AuthResponse(
          username: email, isAuthenticated: false, message: e.message!);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception("Failed to sign out: $e");
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> uploadWorkout(Workout workout) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not signed in');

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('workouts')
          .doc("${workout.title} - ${workout.timestamp}")
          .set(workout.toJson());
    } catch (e) {
      throw Exception("Failed to add workout to Firebase: $e");
    }
  }

  Future<List<Workout>> getWorkouts() async {
    try {
      final user = _auth.currentUser;

      if (user == null) throw Exception("User not signed in.");

      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('workouts')
          .get();
      return snapshot.docs.map((doc) => Workout.fromJson(doc.data())).toList();
    } catch (e) {
      throw Exception("Failed to fetch workouts from Firebase: $e");
    }
  }

  Future<void> addGoal(Goal goal) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not signed in');

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('goals')
          .doc(goal.id)
          .set(goal.toJson());
    } catch (e) {
      throw Exception("Failed to add workout to Firebase: $e");
    }
  }

  Stream<List<Goal>> getGoals() {
    final user = _auth.currentUser;
    return _firestore
        .collection('goals')
        .where('userId', isEqualTo: user!.uid)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Goal.fromJson(doc.data()))
            .toList());
  }
}
