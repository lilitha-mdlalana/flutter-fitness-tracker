import 'package:fitquest/data/datasources/local/workout_dao.dart';
import 'package:fitquest/data/datasources/remote/firebase_service.dart';

import '../../data/models/workout_model.dart';

abstract class SaveWorkout{
  Future<void> saveWorkout(Workout workout);
  Future<List<Workout>> fetchWorkouts();
}

class SaveWorkoutImpl implements SaveWorkout{
  final WorkoutDAO _workoutDao;
  final FirebaseService _firebaseService;

  SaveWorkoutImpl(this._workoutDao, this._firebaseService);

  @override
  Future<void> saveWorkout(Workout workout) async {
    await _workoutDao.insertWorkout(workout);
    if(await _firebaseService.isOnline()){
      await _firebaseService.uploadWorkout(workout);
    }
  }
  @override
  Future<List<Workout>> fetchWorkouts() async {
    return await _workoutDao.getWorkouts();
  }
}