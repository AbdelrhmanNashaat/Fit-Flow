import 'package:fit_flow/features/onboarding/domain/models/onboarding_goal.dart';
import 'package:flutter/material.dart';

class GoalModel {
  const GoalModel({required this.goal, required this.icon});

  final OnboardingGoal goal;
  final IconData icon;
}

const List<GoalModel> kGoals = [
  GoalModel(
    goal: OnboardingGoal.buildMuscle,
    icon: Icons.fitness_center_rounded,
  ),
  GoalModel(
    goal: OnboardingGoal.getStrong,
    icon: Icons.sports_gymnastics_rounded,
  ),
  GoalModel(
    goal: OnboardingGoal.generalFitness,
    icon: Icons.directions_run_rounded,
  ),
];
