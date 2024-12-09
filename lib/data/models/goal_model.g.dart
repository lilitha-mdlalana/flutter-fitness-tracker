// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goal _$GoalFromJson(Map<String, dynamic> json) => Goal(
      id: json['id'] as String,
      userId: json['userId'] as String,
      goalType: $enumDecode(_$GoalTypeEnumMap, json['goalType']),
      goalValue: (json['goalValue'] as num).toDouble(),
    );

Map<String, dynamic> _$GoalToJson(Goal instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'goalType': _$GoalTypeEnumMap[instance.goalType]!,
      'goalValue': instance.goalValue,
    };

const _$GoalTypeEnumMap = {
  GoalType.distance: 'distance',
  GoalType.calories: 'calories',
  GoalType.runs: 'runs',
};
