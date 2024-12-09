import 'package:fitquest/presentation/screens/activity/widgets/hoverable_list_tile.dart';
import 'package:fitquest/presentation/screens/activity_details/activity_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/activity_view_model.dart';

class ActivityScreen extends StatefulWidget {
  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ActivityViewModel>().fetchWorkouts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ActivityViewModel>();
    return Scaffold(
      body: viewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : viewModel.workouts.isEmpty
              ? const Center(
                  child: Text("No activities found."),
                )
              : ListView.builder(
                  itemCount: viewModel.workouts.length,
                  itemBuilder: (context, index) {
                    final workout = viewModel.workouts[index];
                    return HoverableListTile(
                      workout: workout,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ActivityDetails(workout: workout),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
