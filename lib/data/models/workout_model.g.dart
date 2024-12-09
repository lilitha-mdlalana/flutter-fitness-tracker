// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workout _$WorkoutFromJson(Map<String, dynamic> json) => Workout(
      title: json['title'] as String,
      type: $enumDecode(_$WorkoutTypeEnumMap, json['type']),
      distance: (json['distance'] as num).toDouble(),
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
      routeSnapshot: json['routeSnapshot'] as String,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
      'title': instance.title,
      'type': _$WorkoutTypeEnumMap[instance.type]!,
      'distance': instance.distance,
      'duration': instance.duration.inMicroseconds,
      'routeSnapshot': instance.routeSnapshot,
      'timestamp': instance.timestamp?.toIso8601String(),
    };

const _$WorkoutTypeEnumMap = {
  WorkoutType.run: 'run',
  WorkoutType.cycle: 'cycle',
};
