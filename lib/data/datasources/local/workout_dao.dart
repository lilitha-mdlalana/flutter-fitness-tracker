import 'package:sqflite/sqflite.dart';

import '../../models/workout_model.dart';

class WorkoutDAO {
  final Database _database;

  WorkoutDAO(this._database);

  Future<void> insertWorkout(Workout workout) async {
    await _database.insert('workouts', workout.toJson());
  }

  Future<List<Workout>> getWorkouts() async {
    final List<Map<String, dynamic>> workouts =  await _database.query('workouts');
    return workouts.map((workoutData) => Workout.fromJson(workoutData)).toList();
  }

  Future<void> deleteWorkout(int id) async {
    await _database.delete('workouts', where: 'id = ?', whereArgs: [id]);
  }
}
