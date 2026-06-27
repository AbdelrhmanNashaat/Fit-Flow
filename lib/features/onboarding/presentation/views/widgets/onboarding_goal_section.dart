import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/features/onboarding/domain/models/onboarding_goal.dart';
import 'package:fit_flow/features/onboarding/presentation/models/goal_model.dart';
import 'package:fit_flow/features/onboarding/presentation/views/widgets/goal_option_card.dart';
import 'package:flutter/material.dart';

class OnboardingGoalSection extends StatelessWidget {
  const OnboardingGoalSection({
    super.key,
    required this.selectedGoal,
    required this.onGoalSelected,
  });

  final OnboardingGoal selectedGoal;
  final ValueChanged<OnboardingGoal> onGoalSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: kGoals.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, index) {
        final goal = kGoals[index];
        return GoalOptionCard(
          title: _titleForGoal(l10n, goal.goal),
          subtitle: _subtitleForGoal(l10n, goal.goal),
          icon: goal.icon,
          isSelected: selectedGoal == goal.goal,
          onTap: () => onGoalSelected(goal.goal),
        );
      },
    );
  }

  String _titleForGoal(S l10n, OnboardingGoal goal) {
    return switch (goal) {
      OnboardingGoal.buildMuscle => l10n.buildMuscle,
      OnboardingGoal.getStrong => l10n.getStrong,
      OnboardingGoal.generalFitness => l10n.generalFitness,
    };
  }

  String _subtitleForGoal(S l10n, OnboardingGoal goal) {
    return switch (goal) {
      OnboardingGoal.buildMuscle => l10n.buildMuscleSubtitle,
      OnboardingGoal.getStrong => l10n.getStrongSubtitle,
      OnboardingGoal.generalFitness => l10n.generalFitnessSubtitle,
    };
  }
}
