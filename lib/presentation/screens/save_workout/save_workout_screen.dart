import 'dart:typed_data';
import 'package:fitquest/core/enums/workout_type.dart';
import 'package:fitquest/presentation/screens/activity_details/activity_details.dart';
import 'package:fitquest/presentation/view_models/home_view_model.dart';
import 'package:fitquest/presentation/widgets/custom_button.dart';
import 'package:fitquest/presentation/widgets/shared/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import '../../../data/models/workout_model.dart';
import '../../view_models/save_workout_view_model.dart';

class SaveWorkoutScreen extends StatelessWidget {
  final Uint8List? mapSnapshot;
  final String title;
  final WorkoutType type;
  final double distance;
  final Duration duration;

  const SaveWorkoutScreen({
    super.key,
    required this.mapSnapshot,
    required this.title,
    required this.type,
    required this.distance,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    WorkoutType workoutType = WorkoutType.run;
    final saveWorkoutViewModel = context.watch<SaveWorkoutViewModel>();
    final homeViewModel = context.read<HomeViewModel>();
    final TextEditingController titleController = TextEditingController();
    
    return Scaffold(
      appBar: AppBar(title: const Text("Save Workout")),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Distance: ${distance.toStringAsFixed(2)} km"),
                Text(
                  "Duration: $duration",
                ),
                const SizedBox(height: 16),
                const Text("Snapshot:"),
                if (mapSnapshot != null)
                  Image.memory(
                    mapSnapshot!,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                const SizedBox(height: 16),
                CustomTextfield(
                  controller: titleController,
                  hintText: 'Workout Name',
                  obscureText: false,
                  enabledBorderColor: Colors.white,
                  focusedBorderColor: Colors.grey,
                  fillColor: Colors.grey.shade200,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: DropdownButtonFormField<WorkoutType>(
                    value: type,
                    items: WorkoutType.values.map((type) {
                      return DropdownMenuItem<WorkoutType>(
                        value: type,
                        child: Container(
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(minHeight: 20),
                          child: Text(type.toString().split('.').last),
                        ),
                      );
                    }).toList(),
                    onChanged: (type) {
                      workoutType = type!;
                    },
                    decoration: InputDecoration(
                      labelText: "Workout Type",
                      fillColor: Colors.grey.shade200,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                CustomButton(
                  onTap: () {
                    final updatedWorkout = Workout(
                      title: titleController.text,
                      type: workoutType,
                      distance: distance,
                      duration: duration,
                      routeSnapshot: base64Encode(mapSnapshot as List<int>),
                      timestamp: DateTime.now(),
                    );
                    saveWorkoutViewModel.saveWorkout(updatedWorkout);
                    homeViewModel.stopRun(clearState:true);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ActivityDetails(workout: updatedWorkout)));
                  },
                  textColor: Colors.white,
                  backgroundColor: Colors.green,
                  buttonText: "Save Workout",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
