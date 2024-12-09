import 'package:fitquest/data/models/goal_model.dart';
import 'package:sqflite/sqflite.dart';

class GoalDao {
  final Database _database;

  GoalDao(this._database);
  
  Future<void> addGoalToLocal(Goal goal) async {
    await _database.insert('goals', goal.toJson());
  }

  Future<List<Goal>> fetchGoalsFromLocal() async {
    final List<Map<String, dynamic>> goals = await _database.query('goals');
    return goals.map((goalData) => Goal.fromJson(goalData)).toList();
  }
}