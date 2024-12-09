
import 'package:fitquest/core/enums/goal_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'goal_model.g.dart';

@JsonSerializable()
class Goal {
  final String id;
  final String userId;
  final GoalType goalType; 
  final double goalValue;

  Goal({
    required this.id,
    required this.userId,
    required this.goalType,
    required this.goalValue,
  });

   factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

  Map<String, dynamic> toJson() => _$GoalToJson(this);
}
