import 'package:fit_flow/core/utils/app_assets.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_navigation.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/core/widgets/custom_app_bar.dart';
import 'package:fit_flow/core/widgets/custom_button.dart';
import 'package:fit_flow/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:fit_flow/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:fit_flow/features/onboarding/presentation/views/widgets/availability_selector.dart';
import 'package:fit_flow/features/onboarding/presentation/views/widgets/goal_option_card.dart';
import 'package:fit_flow/features/onboarding/presentation/views/widgets/recommendation_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomAppBarWidget(
                      title: 'FitFlow',
                      imagePath: Assets.questionIcon,
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'Select Your Goal',
                      style: AppTextStyles.extraBold26.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Customize your journey for precision performance.',
                      style: AppTextStyles.medium14.copyWith(
                        color: AppColors.buttonTextColor2,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),
                    GoalOptionCard(
                      title: 'Build Muscle',
                      subtitle: 'Focus on hypertrophy and strength.',
                      icon: Icons.fitness_center_rounded,
                      isSelected:
                          state.selectedGoal == OnboardingGoal.buildMuscle,
                      onTap: () => context.read<OnboardingCubit>().selectGoal(
                        OnboardingGoal.buildMuscle,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GoalOptionCard(
                      title: 'Get Strong',
                      subtitle: 'Prioritize heavy lifting and power.',
                      icon: Icons.sports_martial_arts_rounded,
                      isSelected:
                          state.selectedGoal == OnboardingGoal.getStrong,
                      onTap: () => context.read<OnboardingCubit>().selectGoal(
                        OnboardingGoal.getStrong,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GoalOptionCard(
                      title: 'General Fitness',
                      subtitle: 'Balanced health and mobility.',
                      icon: Icons.directions_run_rounded,
                      isSelected:
                          state.selectedGoal == OnboardingGoal.generalFitness,
                      onTap: () => context.read<OnboardingCubit>().selectGoal(
                        OnboardingGoal.generalFitness,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'Weekly Availability',
                      style: AppTextStyles.bold18.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    AvailabilitySelector(
                      selectedDays: state.selectedAvailabilityDays,
                      onSelected: context
                          .read<OnboardingCubit>()
                          .selectAvailabilityDays,
                    ),
                    const SizedBox(height: 24),
                    const RecommendationCard(),
                    const SizedBox(height: 28),
                    CustomButton(
                      text: 'Continue',
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushReplacementNamed(AppNavigation.home);
                      },
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Text(
                        'YOU CAN CHANGE THIS LATER IN PROFILE',
                        style: AppTextStyles.medium12.copyWith(
                          color: AppColors.borderColor,
                          letterSpacing: 0.8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
