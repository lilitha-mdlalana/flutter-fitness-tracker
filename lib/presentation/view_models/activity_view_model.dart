import 'package:flutter/material.dart';
import '../../data/models/workout_model.dart';
import '../../domain/repositories/workout_repository.dart';

class ActivityViewModel extends ChangeNotifier {
  final SaveWorkout _saveWorkout;

  ActivityViewModel(this._saveWorkout);

  List<Workout> _workouts = [];
  List<Workout> get workouts => _workouts;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> fetchWorkouts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _workouts = await _saveWorkout.fetchWorkouts();
    } catch (e) {
      // Handle errors if needed
      debugPrint(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
