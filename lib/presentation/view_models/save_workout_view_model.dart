import 'package:flutter/material.dart';

import '../../data/datasources/local/workout_dao.dart';
import '../../data/datasources/remote/firebase_service.dart';
import '../../data/models/workout_model.dart';

class SaveWorkoutViewModel extends ChangeNotifier {
  final WorkoutDAO _workoutDAO;
  final FirebaseService _firebaseService;

  SaveWorkoutViewModel(this._workoutDAO, this._firebaseService);

  Future<void> saveWorkout(Workout workout) async {
    await _workoutDAO.insertWorkout(workout);
    await _firebaseService.uploadWorkout(workout);
    notifyListeners();
  }
}
