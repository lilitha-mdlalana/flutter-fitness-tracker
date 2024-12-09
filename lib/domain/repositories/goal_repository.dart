import 'package:fitquest/data/datasources/local/goal_dao.dart';
import 'package:fitquest/data/datasources/remote/firebase_service.dart';
import 'package:fitquest/data/models/goal_model.dart';

class GoalRepository {
  final FirebaseService _firebaseService;
  final GoalDao _goalDao;

  GoalRepository(this._firebaseService, this._goalDao);

  Future<void> addGoal(Goal goal) async { 
    await _goalDao.addGoalToLocal(goal);
    await _firebaseService.addGoal(goal);
  }

  Stream<List<Goal>> getGoals() =>
   _firebaseService.getGoals();

  Future<List<Goal>> getLocalGoals() => _goalDao.fetchGoalsFromLocal();

  
}