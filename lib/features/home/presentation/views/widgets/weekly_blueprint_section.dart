import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/core/utils/date_utils_ext.dart';
import 'package:fit_flow/features/home/presentation/cubit/home_state.dart';
import 'package:flutter/material.dart';

class WeeklyBlueprintSection extends StatelessWidget {
  const WeeklyBlueprintSection({super.key, required this.weekSchedule});

  final List<DayStatus> weekSchedule;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final weekNum = AppDateUtils.currentWeekNumber();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(l10n.weeklyBlueprint, style: AppTextStyles.bold16.copyWith(color: AppColors.blackColor)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                l10n.weekLabel(weekNum),
                style: AppTextStyles.bold14.copyWith(
                  color: AppColors.buttonColor,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: weekSchedule
              .map((day) => _DayChip(
                    status: day,
                    date: AppDateUtils.dateForWeekday(day.weekday).day,
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({required this.status, required this.date});

  final DayStatus status;
  final int date;

  static const _dayLetters = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    final isToday = status.weekday == DateTime.now().weekday;
    final isWorkout = status.kind == DayKind.workout;

    Color bg;
    Color fg;
    Border? border;

    if (isToday) {
      bg = AppColors.buttonColor;
      fg = AppColors.whiteColor;
    } else if (isWorkout) {
      bg = AppColors.whiteColor;
      fg = AppColors.buttonColor;
      border = Border.all(color: AppColors.buttonColor, width: 1.5);
    } else {
      bg = AppColors.backgroundScaffold;
      fg = AppColors.orTextColor;
      border = Border.all(color: AppColors.dividerLight);
    }

    return Column(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: bg,
            shape: BoxShape.circle,
            border: border,
          ),
          alignment: Alignment.center,
          child: Text(
            '$date',
            style: AppTextStyles.bold14.copyWith(color: fg, fontSize: 13),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _dayLetters[status.weekday - 1],
          style: AppTextStyles.regular14.copyWith(
            color: isToday ? AppColors.buttonColor : AppColors.orTextColor,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
