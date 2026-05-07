import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/features/workout/data/models/exercise_model.dart';
import 'package:flutter/material.dart';

class ExerciseMediaSection extends StatelessWidget {
  const ExerciseMediaSection({super.key, required this.exercise});

  final ExerciseModel exercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          if (exercise.imageAsset != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                exercise.imageAsset!,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            )
          else
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.fitness_center_rounded,
                    size: 64,
                    color: AppColors.buttonColor,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    exercise.muscleGroup,
                    style: AppTextStyles.bold14.copyWith(
                      color: AppColors.buttonColor,
                    ),
                  ),
                ],
              ),
            ),
          Positioned(
            bottom: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.buttonColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                exercise.equipment,
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.whiteColor,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
