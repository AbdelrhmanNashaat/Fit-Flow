import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_navigation.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/features/home/presentation/cubit/home_cubit.dart';
import 'package:fit_flow/features/home/presentation/cubit/home_state.dart';
import 'package:fit_flow/features/home/presentation/views/widgets/active_workout_card.dart';
import 'package:fit_flow/features/home/presentation/views/widgets/dashboard_header.dart';
import 'package:fit_flow/features/home/presentation/views/widgets/stats_info_card.dart';
import 'package:fit_flow/features/home/presentation/views/widgets/today_exercise_tile.dart';
import 'package:fit_flow/features/home/presentation/views/widgets/weekly_blueprint_section.dart';
import 'package:fit_flow/features/workout/data/models/workout_day_model.dart';
import 'package:fit_flow/features/workout/presentation/models/active_exercise_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => switch (state) {
        HomeInitial() ||
        HomeLoading() => const Center(child: CircularProgressIndicator()),
        HomeError(:final message) => Center(
          child: Text(message, style: AppTextStyles.regular14),
        ),
        HomeLoaded() => _HomeContent(state: state),
      },
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.state});

  final HomeLoaded state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
        children: [
          // ── Header ───────────────────────────────────────────────
          DashboardHeader(greeting: state.greeting, userName: state.userName),
          const SizedBox(height: 24),
          // ── Weekly blueprint ─────────────────────────────────────
          WeeklyBlueprintSection(weekSchedule: state.weekSchedule),
          const SizedBox(height: 24),
          // ── Active plan card or rest ──────────────────────────────
          if (state.todayDay != null)
            ActiveWorkoutCard(
              plan: state.plan,
              day: state.todayDay!,
              onStart: () => _navigateToExercise(context, state.todayDay!, 0),
            )
          else
            _RestDayCard(l10n: l10n),
          const SizedBox(height: 24),
          // ── Today's exercises ─────────────────────────────────────
          if (state.todayDay != null) ...[
            Text(l10n.todayExercises, style: AppTextStyles.bold16),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.dividerLight),
              ),
              child: Column(
                children: [
                  for (
                    int i = 0;
                    i < state.todayDay!.exercises.length;
                    i++
                  ) ...[
                    TodayExerciseTile(
                      dayExercise: state.todayDay!.exercises[i],
                      index: i,
                      onTap: () =>
                          _navigateToExercise(context, state.todayDay!, i),
                    ),
                    if (i < state.todayDay!.exercises.length - 1)
                      const Divider(
                        height: 1,
                        indent: 68,
                        endIndent: 16,
                        color: AppColors.dividerLight,
                      ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
          // ── Stats row ─────────────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: StatsInfoCard(
                  icon: Icons.battery_charging_full_rounded,
                  label: l10n.recovery,
                  value: '94%',
                  subtitle: 'Optimal status for training today.',
                  color: AppColors.success,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatsInfoCard(
                  icon: Icons.local_fire_department_rounded,
                  label: l10n.weeklyBurn,
                  value: '2,450',
                  subtitle: 'Active kcal burned this week.',
                  color: AppColors.warning,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToExercise(
    BuildContext context,
    WorkoutDayModel day,
    int index,
  ) {
    Navigator.of(context, rootNavigator: true).pushNamed(
      AppNavigation.activeExercise,
      arguments: ActiveExerciseArgs(day: day, startIndex: index),
    );
  }
}

class _RestDayCard extends StatelessWidget {
  const _RestDayCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.dividerLight),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.self_improvement_rounded,
            size: 48,
            color: AppColors.orTextColor,
          ),
          const SizedBox(height: 12),
          Text(l10n.restDay, style: AppTextStyles.bold16),
          const SizedBox(height: 4),
          Text(
            l10n.letsRestToday,
            style: AppTextStyles.regular14.copyWith(
              color: AppColors.orTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

