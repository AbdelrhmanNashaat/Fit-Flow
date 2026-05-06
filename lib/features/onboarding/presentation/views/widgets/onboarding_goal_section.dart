import 'package:fit_flow/features/onboarding/presentation/cubit/onboarding_state.dart';
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
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: kGoals.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, index) {
        final goal = kGoals[index];
        return GoalOptionCard(
          title: goal.title,
          subtitle: goal.subtitle,
          icon: goal.icon,
          isSelected: selectedGoal == goal.goal,
          onTap: () => onGoalSelected(goal.goal),
        );
      },
    );
  }
}
