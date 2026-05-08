import 'package:fit_flow/core/service/service_locator.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_spacing.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/features/learn/data/models/learn_item.dart';
import 'package:fit_flow/features/learn/domain/repo/learn_repo.dart';
import 'package:fit_flow/features/learn/presentation/cubit/learn_cubit.dart';
import 'package:fit_flow/features/learn/presentation/cubit/learn_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ─── View ─────────────────────────────────────────────────────────────────────

class LearnView extends StatelessWidget {
  const LearnView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LearnCubit(getIt<LearnRepo>()),
      child: const _LearnBody(),
    );
  }
}

class _LearnBody extends StatelessWidget {
  const _LearnBody();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LearnCubit>().state;
    if (state is! LearnLoaded) return const SizedBox.shrink();

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          0,
          AppSpacing.md,
          0,
          AppSpacing.tabBarClearance + AppSpacing.md,
        ),
        children: [
          // ── Title bar ───────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Learn',
                    style: AppTextStyles.extraBold26.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ),
                const Icon(
                  Icons.search_rounded,
                  color: AppColors.orTextColor,
                  size: 24,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // ── Featured card ───────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _FeaturedCard(item: state.featured),
          ),
          const SizedBox(height: 20),
          // ── Category chips ──────────────────────────────────────
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: state.categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final cat = state.categories[i];
                final selected = cat == state.selectedCategory;
                return GestureDetector(
                  onTap: () =>
                      context.read<LearnCubit>().selectCategory(cat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.buttonColor
                          : AppColors.backgroundScaffold,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: selected
                            ? AppColors.buttonColor
                            : AppColors.dividerLight,
                      ),
                    ),
                    child: Text(
                      cat,
                      style: AppTextStyles.bold14.copyWith(
                        fontSize: 12,
                        color: selected
                            ? AppColors.whiteColor
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // ── Video list ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: state.filtered.map((v) => _VideoCard(item: v)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Featured card ────────────────────────────────────────────────────────────

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({required this.item});
  final LearnItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [item.color, item.color.withValues(alpha: 0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 16,
            top: 16,
            child: Icon(
              item.icon,
              size: 80,
              color: AppColors.whiteColor.withValues(alpha: 0.15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    item.category,
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.whiteColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  item.title,
                  style: AppTextStyles.extraBold26.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: 20,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.play_circle_outline_rounded,
                      size: 16,
                      color: AppColors.whiteColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item.channel,
                      style: AppTextStyles.regular14.copyWith(
                        color: AppColors.whiteColor.withValues(alpha: 0.85),
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      item.duration,
                      style: AppTextStyles.bold14.copyWith(
                        color: AppColors.whiteColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Video card ───────────────────────────────────────────────────────────────

class _VideoCard extends StatelessWidget {
  const _VideoCard({required this.item});
  final LearnItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.dividerLight),
      ),
      child: Row(
        children: [
          // Thumbnail
          Container(
            width: 90,
            height: 72,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.12),
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(13),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(item.icon, size: 28, color: item.color),
                Positioned(
                  bottom: 6,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.blackColor.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      item.duration,
                      style: AppTextStyles.regular14.copyWith(
                        color: AppColors.whiteColor,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: item.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      item.category,
                      style: AppTextStyles.regular14.copyWith(
                        color: item.color,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.title,
                    style: AppTextStyles.bold14.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.channel,
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.orTextColor,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(
              Icons.chevron_right_rounded,
              color: AppColors.orTextColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
