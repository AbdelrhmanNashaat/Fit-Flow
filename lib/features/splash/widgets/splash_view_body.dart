import 'package:fit_flow/core/utils/app_assets.dart';
import 'package:fit_flow/core/utils/app_navigation.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/utils/app_colors.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssets.splashImage, height: 180)
              .animate()
              .fadeIn(duration: 700.ms)
              .scale(
                begin: const Offset(0.6, 0.6),
                end: const Offset(1, 1),
                duration: 900.ms,
                curve: Curves.elasticOut,
              ),

          Text('FitFlow', style: AppTextStyles.bold48)
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
              )
              .animate(
                delay: 700.ms,
                onComplete: (_) {
                  Navigator.pushReplacementNamed(context, AppNavigation.signUp);
                },
              )
              .fadeIn(duration: 700.ms),
        ],
      ),
    );
  }
}
