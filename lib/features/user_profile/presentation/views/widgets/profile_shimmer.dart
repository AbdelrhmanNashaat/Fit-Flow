import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.fillColor,
      highlightColor: AppColors.whiteColor,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  _box(width: 130, height: 22),
                  const Spacer(),
                  _box(width: 24, height: 24, radius: 4),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  Center(child: _box(width: 88, height: 88, radius: 44)),
                  const SizedBox(height: 12),
                  Center(child: _box(width: 160, height: 22)),
                  const SizedBox(height: 8),
                  Center(child: _box(width: 200, height: 14)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _box(height: 80)),
                      const SizedBox(width: 10),
                      Expanded(child: _box(height: 80)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _box(width: 200, height: 14),
                  const SizedBox(height: 8),
                  _box(height: 220, radius: 12),
                  const SizedBox(height: 16),
                  _box(height: 100, radius: 12),
                  const SizedBox(height: 16),
                  Center(child: _box(width: 160, height: 14)),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _box({double? width, required double height, double radius = 8}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.fillColor,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
