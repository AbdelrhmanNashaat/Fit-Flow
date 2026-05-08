import 'dart:io';

import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/features/user_profile/data/model/user_profile.dart';
import 'package:fit_flow/features/user_profile/presentation/views/widgets/profile_stat_item.dart';
import 'package:flutter/material.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({
    super.key,
    required this.userName,
    required this.profile,
    this.localImagePath,
    this.isImageUploading = false,
    this.onEditTap,
  });

  final String userName;
  final UserProfile profile;
  final String? localImagePath;
  final bool isImageUploading;
  final VoidCallback? onEditTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        _ProfileAvatar(
          name: userName,
          localImagePath: localImagePath,
          isUploading: isImageUploading,
          onEditTap: onEditTap,
        ),
        const SizedBox(height: 12),
        Text(
          userName,
          style: AppTextStyles.extraBold26,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          l10n.memberSince(profile.createdAt),
          style: AppTextStyles.regular14.copyWith(color: AppColors.orTextColor),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            ProfileStatItem(
              icon: Icons.fitness_center_rounded,
              label: l10n.activeGoal,
              value: _formatGoal(l10n, profile.myGoal),
            ),
            const SizedBox(width: 10),
            ProfileStatItem(
              icon: Icons.calendar_today_rounded,
              label: l10n.frequency,
              value: profile.weeklyAvailability != null
                  ? l10n.daysPerWeek(profile.weeklyAvailability!)
                  : l10n.notSet,
            ),
          ],
        ),
      ],
    );
  }

  String _formatGoal(AppLocalizations l10n, String? goal) => switch (goal) {
    'buildMuscle' => l10n.buildMuscle,
    'getStrong' => l10n.getStrong,
    'generalFitness' => l10n.generalFitness,
    _ => l10n.notSet,
  };
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({
    required this.name,
    this.localImagePath,
    this.isUploading = false,
    this.onEditTap,
  });

  final String name;
  final String? localImagePath;
  final bool isUploading;
  final VoidCallback? onEditTap;

  @override
  Widget build(BuildContext context) {
    final initials = name
        .split(' ')
        .where((w) => w.isNotEmpty)
        .take(2)
        .map((w) => w[0].toUpperCase())
        .join();

    final ImageProvider? imageProvider = localImagePath != null
        ? FileImage(File(localImagePath!))
        : null;

    return Stack(
      children: [
        CircleAvatar(
          radius: 44,
          backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
          backgroundImage: imageProvider,
          child: imageProvider == null
              ? Text(
                  initials.isNotEmpty ? initials : '?',
                  style: AppTextStyles.extraBold30.copyWith(
                    color: AppColors.primaryColor,
                  ),
                )
              : null,
        ),
        if (isUploading)
          const Positioned.fill(
            child: CircleAvatar(
              radius: 44,
              backgroundColor: Colors.black26,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              ),
            ),
          ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: isUploading ? null : onEditTap,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.buttonColor,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.whiteColor, width: 2),
              ),
              child: isUploading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(
                      Icons.edit,
                      size: 18,
                      color: AppColors.whiteColor,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
