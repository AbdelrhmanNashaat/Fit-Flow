import 'package:fit_flow/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:flutter/material.dart';

class GoalModel {
  const GoalModel({
    required this.goal,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final OnboardingGoal goal;
  final String title;
  final String subtitle;
  final IconData icon;
}

const List<GoalModel> kGoals = [
  GoalModel(
    goal: OnboardingGoal.buildMuscle,
    title: 'Build Muscle',
    subtitle: 'Focus on hypertrophy and strength.',
    icon: Icons.fitness_center_rounded,
  ),
  GoalModel(
    goal: OnboardingGoal.getStrong,
    title: 'Get Strong',
    subtitle: 'Prioritize heavy lifting and power.',
    icon: Icons.sports_gymnastics_rounded,
  ),
  GoalModel(
    goal: OnboardingGoal.generalFitness,
    title: 'General Fitness',
    subtitle: 'Balanced health and mobility.',
    icon: Icons.directions_run_rounded,
  ),
];
