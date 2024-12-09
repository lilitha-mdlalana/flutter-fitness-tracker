import 'package:fitquest/data/models/goal_model.dart';
import 'package:fitquest/domain/repositories/goal_repository.dart';
import 'package:flutter/material.dart';

class GoalsViewModel extends ChangeNotifier {
  final GoalRepository _goalRepository;

  GoalsViewModel(this._goalRepository);

  List<Goal> _goals = [];
  List<Goal> get goals => _goals;


  Future<void> addGoal(Goal goal) async {
    await _goalRepository.addGoal(goal);
  }

  Future<void> getGoals() async {
    _goals = await _goalRepository.getLocalGoals();
    notifyListeners();
  }
}
