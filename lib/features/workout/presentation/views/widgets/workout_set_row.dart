import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/features/workout/data/models/workout_set_model.dart';
import 'package:flutter/material.dart';

/// Table-style row matching the design: SET | WEIGHT | REPS | DONE
class WorkoutSetRow extends StatelessWidget {
  const WorkoutSetRow({
    super.key,
    required this.set,
    required this.onToggle,
    required this.onWeightTap,
  });

  final WorkoutSetModel set;
  final VoidCallback onToggle;
  final VoidCallback onWeightTap;

  @override
  Widget build(BuildContext context) {
    final isCompleted = set.isCompleted;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isCompleted
            ? AppColors.successLight
            : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCompleted ? AppColors.success : AppColors.dividerLight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            // SET
            SizedBox(
              width: 32,
              child: Text(
                '${set.setNumber}',
                style: AppTextStyles.bold14.copyWith(
                  color: isCompleted ? AppColors.success : AppColors.orTextColor,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // WEIGHT
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: onWeightTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundScaffold,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.dividerLight),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    set.weightKg != null
                        ? '${set.weightKg!.toStringAsFixed(set.weightKg! % 1 == 0 ? 0 : 1)}kg'
                        : '—',
                    style: AppTextStyles.bold14.copyWith(fontSize: 13),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // REPS
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: AppColors.backgroundScaffold,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.dividerLight),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${set.reps}',
                  style: AppTextStyles.bold14.copyWith(fontSize: 13),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // DONE
            GestureDetector(
              onTap: onToggle,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: isCompleted ? AppColors.success : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isCompleted ? AppColors.success : AppColors.borderColor,
                    width: 1.5,
                  ),
                ),
                child: isCompleted
                    ? const Icon(Icons.check, size: 16, color: AppColors.whiteColor)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Column headers for the sets table.
class SetTableHeader extends StatelessWidget {
  const SetTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.regular14.copyWith(
      color: AppColors.orTextColor,
      fontSize: 11,
      fontWeight: FontWeight.w600,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Text('SET', style: style, textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 3,
            child: Text('WEIGHT', style: style, textAlign: TextAlign.center),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text('REPS', style: style, textAlign: TextAlign.center),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 30,
            child: Text('DONE', style: style, textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
