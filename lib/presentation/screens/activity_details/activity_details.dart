import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fitquest/data/models/workout_model.dart';

import '../../../core/enums/workout_type.dart';

class ActivityDetails extends StatelessWidget {
  final Workout workout;

  const ActivityDetails({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    final mapSnapshot = base64Decode(workout.routeSnapshot);

    return Scaffold(
      appBar: AppBar(
        title: Text(workout.title),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: Image.memory(
              mapSnapshot,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatRow(
                      icon: workout.type == WorkoutType.run ? Icons.directions_run : Icons.directions_bike,
                      title: "Workout Type",
                      value: workout.type == WorkoutType.run ? "Run" : "Cycle",
                    ),
                    const SizedBox(height: 16),
                    _buildStatRow(
                      icon: Icons.route,
                      title: "Distance",
                      value: "${workout.distance.toStringAsFixed(2)} km",
                    ),
                    const SizedBox(height: 16),
                    _buildStatRow(
                      icon: Icons.timer,
                      title: "Duration",
                      value: "${workout.duration.inMinutes} min",
                    ),
                    const SizedBox(height: 16),
                    _buildStatRow(
                      icon: Icons.description,
                      title: "Description",
                      value: workout.title,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
