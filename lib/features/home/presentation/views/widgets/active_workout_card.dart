import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/features/workout/data/models/workout_day_model.dart';
import 'package:fit_flow/features/workout/data/models/workout_plan_model.dart';
import 'package:flutter/material.dart';

class ActiveWorkoutCard extends StatelessWidget {
  const ActiveWorkoutCard({
    super.key,
    required this.plan,
    required this.day,
    required this.onStart,
  });

  final WorkoutPlanModel plan;
  final WorkoutDayModel day;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final exerciseCount = day.exercises.length;
    final totalSets = day.exercises.fold(0, (s, e) => s + e.defaultSets);
    final estimatedMinutes = totalSets * 3; // 3 min per set incl. rest

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A3FAB), AppColors.primaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.whiteColor.withValues(alpha: 0.05),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: -30,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.whiteColor.withValues(alpha: 0.05),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.bolt_rounded,
                        size: 13,
                        color: AppColors.whiteColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        l10n.activePlan,
                        style: AppTextStyles.regular14.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Plan + day name
                Text(
                  '${plan.name} · ${day.name}',
                  style: AppTextStyles.extraBold26.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: 22,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 10),
                // Stats badges
                Row(
                  children: [
                    _Badge(
                      icon: Icons.timer_outlined,
                      label: '$estimatedMinutes ${l10n.minutes}',
                    ),
                    const SizedBox(width: 14),
                    _Badge(
                      icon: Icons.fitness_center_rounded,
                      label: l10n.exerciseCount(exerciseCount),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                // Start button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onStart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.whiteColor,
                      foregroundColor: AppColors.buttonColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      l10n.startWorkout,
                      style: AppTextStyles.bold16.copyWith(
                        color: AppColors.buttonColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.whiteColor.withValues(alpha: 0.8)),
        const SizedBox(width: 5),
        Text(
          label,
          style: AppTextStyles.regular14.copyWith(
            color: AppColors.whiteColor.withValues(alpha: 0.9),
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
