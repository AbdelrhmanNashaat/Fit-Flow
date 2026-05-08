import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/features/workout/presentation/models/active_exercise_args.dart';
import 'package:fit_flow/features/workout/presentation/cubit/active_exercise_cubit.dart';
import 'package:fit_flow/features/workout/presentation/cubit/active_exercise_state.dart';
import 'package:fit_flow/features/workout/presentation/views/widgets/add_set_button.dart';
import 'package:fit_flow/features/workout/presentation/views/widgets/exercise_media_section.dart';
import 'package:fit_flow/features/workout/presentation/views/widgets/form_cue_card.dart';
import 'package:fit_flow/features/workout/presentation/views/widgets/starting_weight_bottom_sheet.dart';
import 'package:fit_flow/features/workout/presentation/views/widgets/workout_set_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveExerciseView extends StatelessWidget {
  const ActiveExerciseView({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ActiveExerciseArgs;

    return BlocProvider(
      create: (_) => ActiveExerciseCubit()..start(args.day, args.startIndex),
      child: const _ActiveExerciseScaffold(),
    );
  }
}

class _ActiveExerciseScaffold extends StatelessWidget {
  const _ActiveExerciseScaffold();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActiveExerciseCubit, ActiveExerciseState>(
      listenWhen: (prev, curr) {
        if (curr is ActiveExerciseFinished) return true;
        if (curr is ActiveExerciseReady && curr.showWeightDialog) return true;
        if (curr is ActiveExerciseReady && curr.validationError != null) {
          final prevReady = prev is ActiveExerciseReady;
          return !prevReady || prev.validationError != curr.validationError;
        }
        return false;
      },
      listener: (context, state) async {
        if (state is ActiveExerciseFinished) {
          Navigator.of(context).pop();
          return;
        }
        if (state is ActiveExerciseReady && state.showWeightDialog) {
          final cubit = context.read<ActiveExerciseCubit>();
          final weight = await StartingWeightDialog.show(context);
          cubit.dismissWeightDialog(weight);
          return;
        }
        if (state is ActiveExerciseReady && state.validationError != null) {
          final l10n = context.l10n;
          final msg = state.validationError == 'completeAllSets'
              ? l10n.validationCompleteAllSets
              : l10n.validationAddWeight;
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(msg),
                backgroundColor: AppColors.warning,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
              ),
            );
          context.read<ActiveExerciseCubit>().clearValidationError();
        }
      },
      // Only rebuild the body when exercise content changes — timer ticks are
      // handled inside _ExerciseTimerDisplay and _RestTimerButton via their
      // own selectors.
      buildWhen: (prev, curr) {
        if (curr is! ActiveExerciseReady || prev is! ActiveExerciseReady) {
          return true;
        }
        return prev.currentIndex != curr.currentIndex ||
            prev.sets != curr.sets ||
            prev.showWeightDialog != curr.showWeightDialog ||
            prev.validationError != curr.validationError;
      },
      builder: (context, state) {
        if (state is! ActiveExerciseReady) return const SizedBox.shrink();
        return _ActiveExerciseBody(state: state);
      },
    );
  }
}

class _ActiveExerciseBody extends StatelessWidget {
  const _ActiveExerciseBody({required this.state});

  final ActiveExerciseReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<ActiveExerciseCubit>();
    final ex = state.currentDayExercise.exercise;

    return Scaffold(
      backgroundColor: AppColors.backgroundScaffold,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimary, size: 22),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(l10n.workoutSession, style: AppTextStyles.bold16.copyWith(color: AppColors.blackColor)),
        centerTitle: true,
        actions: [
          const _ExerciseTimerDisplay(),
          TextButton(
            onPressed: () => cubit.tryFinish(),
            child: Text(
              l10n.finishExercise,
              style: AppTextStyles.bold14.copyWith(
                color: AppColors.buttonColor,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        children: [
          // ── Media ────────────────────────────────────────────────
          ExerciseMediaSection(exercise: ex),
          const SizedBox(height: 14),
          // ── Exercise name ─────────────────────────────────────────
          Text(ex.name, style: AppTextStyles.bold18.copyWith(color: AppColors.blackColor)),
          const SizedBox(height: 16),
          // ── Form cues ─────────────────────────────────────────────
          FormCueCard(cues: ex.formCues),
          const SizedBox(height: 20),
          // ── Sets table ────────────────────────────────────────────
          const SetTableHeader(),
          const SizedBox(height: 4),
          ...state.sets.asMap().entries.map(
            (e) => WorkoutSetRow(
              set: e.value,
              onToggle: () => cubit.toggleSet(e.key),
              onWeightTap: () => _showWeightDialog(context, cubit, e.key, e.value.weightKg),
            ),
          ),
          const SizedBox(height: 4),
          AddSetButton(onTap: cubit.addSet),
          const SizedBox(height: 90),
        ],
      ),
      bottomSheet: const _RestTimerButton(),
    );
  }

  Future<void> _showWeightDialog(
    BuildContext context,
    ActiveExerciseCubit cubit,
    int setIndex,
    double? current,
  ) async {
    final weight = await StartingWeightDialog.show(context, initialWeight: current);
    if (weight != null) cubit.updateSetWeight(setIndex, weight);
  }
}

// ─── Elapsed timer in the app bar — rebuilds only on elapsed-second ticks ─────

class _ExerciseTimerDisplay extends StatelessWidget {
  const _ExerciseTimerDisplay();

  String _format(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ActiveExerciseCubit, ActiveExerciseState, int>(
      selector: (s) => s is ActiveExerciseReady ? s.elapsedSeconds : 0,
      builder: (context, elapsed) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          _format(elapsed),
          style: AppTextStyles.regular14.copyWith(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}

// ─── Rest timer button — rebuilds only when restTimerSeconds changes ──────────

class _RestTimerButton extends StatelessWidget {
  const _RestTimerButton();

  String _formatTimer(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ActiveExerciseCubit, ActiveExerciseState, int?>(
      selector: (s) => s is ActiveExerciseReady ? s.restTimerSeconds : null,
      builder: (context, restSeconds) {
        final l10n = context.l10n;
        final cubit = context.read<ActiveExerciseCubit>();
        final isRunning = restSeconds != null;
        final label = isRunning
            ? '${l10n.startRestTimer}  (${_formatTimer(restSeconds)})'
            : '${l10n.startRestTimer}  (01:30)';

        return Container(
          color: AppColors.whiteColor,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isRunning ? null : cubit.startRestTimer,
              style: ElevatedButton.styleFrom(
                backgroundColor: isRunning
                    ? AppColors.success
                    : AppColors.buttonColor,
                disabledBackgroundColor: AppColors.success,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 0,
              ),
              icon: Icon(
                isRunning ? Icons.timer : Icons.timer_outlined,
                color: AppColors.whiteColor,
                size: 20,
              ),
              label: Text(
                label,
                style: AppTextStyles.bold14.copyWith(color: AppColors.whiteColor),
              ),
            ),
          ),
        );
      },
    );
  }
}
