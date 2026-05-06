import 'package:fit_flow/core/utils/app_assets.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 138,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        image: const DecorationImage(
          image: AssetImage(Assets.exerciseRoutine),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              AppColors.whiteColor.withValues(alpha: 0.86),
              AppColors.whiteColor.withValues(alpha: 0.18),
            ],
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              'RECOMMENDED',
              style: AppTextStyles.semiBold12.copyWith(
                color: AppColors.primaryColor,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Optimal recovery cycle',
                style: AppTextStyles.medium12.copyWith(
                  color: AppColors.buttonTextColor2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
