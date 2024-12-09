import 'package:json_annotation/json_annotation.dart';

import '../../core/enums/workout_type.dart';

part 'workout_model.g.dart';

@JsonSerializable()
class Workout {
  final String title;
  final WorkoutType type;
  final double distance;
  final Duration duration;
  final String routeSnapshot;
  final DateTime? timestamp;

  Workout({required this.title, required this.type, required this.distance, required this.duration, required this.routeSnapshot, required this.timestamp});

  factory Workout.fromJson(Map<String, dynamic> json) => _$WorkoutFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutToJson(this);
}