import 'package:fit_flow/core/utils/app_assets.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fit_flow/core/utils/app_colors.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Assets.splashImage, width: 140)
              .animate()
              .fadeIn(duration: 700.ms)
              .scale(
                begin: const Offset(0.6, 0.6),
                end: const Offset(1, 1),
                duration: 900.ms,
                curve: Curves.elasticOut,
              ),
          const SizedBox(height: 15),
          const Text('FitFlow', style: AppTextStyles.bold48)
              .animate(delay: 400.ms)
              .fadeIn(duration: 600.ms)
              .slideY(
                begin: 0.4,
                end: 0,
                duration: 600.ms,
                curve: Curves.easeOutCubic,
              ),

          Text(
            'ELEVATE YOUR MOVEMENT',
            style: AppTextStyles.light14.copyWith(
              color: AppColors.whiteColor.withValues(alpha: 0.6),
            ),
          ).animate(delay: 700.ms).fadeIn(duration: 700.ms),
        ],
      ),
    );
  }
}
