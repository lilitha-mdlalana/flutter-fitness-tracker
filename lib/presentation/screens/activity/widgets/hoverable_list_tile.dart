import 'package:fitquest/core/enums/workout_type.dart';
import 'package:fitquest/data/models/workout_model.dart';
import 'package:flutter/material.dart';

class HoverableListTile extends StatefulWidget {
  final Workout workout;
  final VoidCallback onTap;

  const HoverableListTile({
    required this.workout,
    required this.onTap,
  });

  @override
  State<HoverableListTile> createState() => _HoverableListTileState();
}

class _HoverableListTileState extends State<HoverableListTile> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Card(
        elevation: isHovered ? 8 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(
            widget.workout.type == WorkoutType.run ? Icons.directions_run : Icons.directions_bike,
            color: widget.workout.type == WorkoutType.run ? Colors.blue : Colors.green,
          ),
          title: Text(widget.workout.title),
          subtitle: Text(
              '${widget.workout.type == WorkoutType.run ? "Run" : "Cycle"} - ${widget.workout.distance.toStringAsFixed(2)} km'),
          trailing: Text('${widget.workout.duration.inMinutes} min'),
          onTap: widget.onTap,
        ),
      ),
    );
  }
}