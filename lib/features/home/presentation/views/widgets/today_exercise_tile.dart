import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/features/workout/data/models/workout_day_model.dart';
import 'package:flutter/material.dart';

class TodayExerciseTile extends StatelessWidget {
  const TodayExerciseTile({
    super.key,
    required this.dayExercise,
    required this.index,
    this.onTap,
  });

  final WorkoutDayExercise dayExercise;
  final int index;
  final VoidCallback? onTap;

  static const _muscleColors = {
    'Chest': Color(0xFFFF6B6B),
    'Shoulders': Color(0xFFFFB347),
    'Triceps': Color(0xFFAD85FF),
    'Back': Color(0xFF4ECDC4),
    'Rear Delts': Color(0xFF45B7D1),
    'Biceps': Color(0xFF96CEB4),
    'Quads': Color(0xFF88D8B0),
    'Hamstrings': Color(0xFFF7DC6F),
    'Calves': Color(0xFFF0A500),
  };

  static const _muscleIcons = {
    'Chest': Icons.self_improvement_rounded,
    'Shoulders': Icons.accessibility_new_rounded,
    'Triceps': Icons.fitness_center_rounded,
    'Back': Icons.airline_seat_flat_rounded,
    'Rear Delts': Icons.rotate_left_rounded,
    'Biceps': Icons.fitness_center_rounded,
    'Quads': Icons.directions_run_rounded,
    'Hamstrings': Icons.directions_walk_rounded,
    'Calves': Icons.directions_walk_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final ex = dayExercise.exercise;
    final color = _muscleColors[ex.muscleGroup] ?? AppColors.primaryColor;
    final icon = _muscleIcons[ex.muscleGroup] ?? Icons.fitness_center_rounded;
    final repsLabel = dayExercise.defaultReps;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ex.name,
                    style: AppTextStyles.bold14.copyWith(color: AppColors.textPrimary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${ex.muscleGroup} & ${ex.equipment}',
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.orTextColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${dayExercise.defaultSets} × $repsLabel',
                  style: AppTextStyles.bold14.copyWith(
                    color: AppColors.buttonColor,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'REPS',
                  style: AppTextStyles.regular14.copyWith(
                    color: AppColors.orTextColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
