import 'package:fitquest/presentation/screens/goals/widgets/add_goal_form.dart';
import 'package:fitquest/presentation/view_models/activity_view_model.dart';
import 'package:fitquest/presentation/view_models/goals_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final goalsViewModel = Provider.of<GoalsViewModel>(context);
    final activities = Provider.of<ActivityViewModel>(context);
    goalsViewModel.getGoals();

    return Scaffold(
      body: goalsViewModel.goals.isEmpty
          ? const Center(child: Text('No goals added yet.'))
          : ListView.builder(
              itemCount: goalsViewModel.goals.length,
              itemBuilder: (context, index) {
                final goal = goalsViewModel.goals[index];
                return ListTile(
                  title: Text(
                      '${goal.goalType.name.toUpperCase()}: ${activities.workouts.length}/${goal.goalValue}'),
                  subtitle: Text('Goal ID: ${goal.id}'),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddGoalForm(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
