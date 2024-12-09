import 'package:fitquest/core/enums/goal_type.dart';
import 'package:fitquest/data/models/goal_model.dart';
import 'package:fitquest/domain/repositories/auth_repository.dart';
import 'package:fitquest/presentation/view_models/goals_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uuid/uuid.dart';

class AddGoalForm extends StatefulWidget {
  const AddGoalForm({
    super.key,
  });

  @override
  State<AddGoalForm> createState() => _AddGoalFormState();
}

class _AddGoalFormState extends State<AddGoalForm> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();

  GoalType _goalType = GoalType.distance;
  double _goalValue = 0.0;

  void _submitForm() {
    final _auth = Provider.of<AuthRepository>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newGoal = Goal(
        id: _uuid.v4(),
        userId: _auth.getCurrentUser()!.uid,
        goalType: _goalType,
        goalValue: _goalValue,
      );

      Provider.of<GoalsViewModel>(context, listen: false).addGoal(newGoal);

      Navigator.pop(context); // Close the form
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Goal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<GoalType>(
                value: _goalType,
                items: GoalType.values
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type.name),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _goalType = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Goal Type'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Goal Value'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a goal value';
                  }
                  return null;
                },
                onSaved: (value) {
                  _goalValue = double.parse(value!);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Confirm Goal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
