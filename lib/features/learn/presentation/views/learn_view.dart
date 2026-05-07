import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

// ─── Static data ─────────────────────────────────────────────────────────────

class _VideoItem {
  const _VideoItem({
    required this.title,
    required this.channel,
    required this.duration,
    required this.category,
    required this.color,
    required this.icon,
  });
  final String title;
  final String channel;
  final String duration;
  final String category;
  final Color color;
  final IconData icon;
}

const _categories = ['All', 'Technique', 'Nutrition', 'Recovery', 'Mindset'];

const _featured = _VideoItem(
  title: 'How to Perfect Your Squat Form',
  channel: 'FitFlow Academy',
  duration: '12:34',
  category: 'Technique',
  color: Color(0xFF1A3FAB),
  icon: Icons.play_circle_fill_rounded,
);

const _videos = [
  _VideoItem(
    title: 'Progressive Overload Explained',
    channel: 'Strength Science',
    duration: '08:21',
    category: 'Technique',
    color: Color(0xFF2563EB),
    icon: Icons.fitness_center_rounded,
  ),
  _VideoItem(
    title: 'Pre-Workout Nutrition Timing',
    channel: 'FitFlow Academy',
    duration: '06:45',
    category: 'Nutrition',
    color: Color(0xFF22C55E),
    icon: Icons.restaurant_rounded,
  ),
  _VideoItem(
    title: 'Sleep & Muscle Recovery',
    channel: 'Recovery Lab',
    duration: '10:12',
    category: 'Recovery',
    color: Color(0xFF8B5CF6),
    icon: Icons.bedtime_rounded,
  ),
  _VideoItem(
    title: 'Bench Press — Full Tutorial',
    channel: 'Strength Science',
    duration: '15:07',
    category: 'Technique',
    color: Color(0xFFF59E0B),
    icon: Icons.sports_gymnastics_rounded,
  ),
  _VideoItem(
    title: 'Protein Intake for Muscle Growth',
    channel: 'FitFlow Academy',
    duration: '09:30',
    category: 'Nutrition',
    color: Color(0xFFEF4444),
    icon: Icons.egg_alt_rounded,
  ),
  _VideoItem(
    title: 'Foam Rolling: Do It Right',
    channel: 'Recovery Lab',
    duration: '07:55',
    category: 'Recovery',
    color: Color(0xFF14B8A6),
    icon: Icons.self_improvement_rounded,
  ),
  _VideoItem(
    title: 'Building a Winning Mindset',
    channel: 'Mind Over Muscle',
    duration: '11:20',
    category: 'Mindset',
    color: Color(0xFFEC4899),
    icon: Icons.psychology_rounded,
  ),
];

// ─── View ─────────────────────────────────────────────────────────────────────

class LearnView extends StatefulWidget {
  const LearnView({super.key});

  @override
  State<LearnView> createState() => _LearnViewState();
}

class _LearnViewState extends State<LearnView> {
  String _selectedCategory = 'All';

  List<_VideoItem> get _filtered => _selectedCategory == 'All'
      ? _videos
      : _videos.where((v) => v.category == _selectedCategory).toList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 120),
        children: [
          // ── Title bar ───────────────────────────────────────────
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text('Learn', style: AppTextStyles.extraBold26),
                ),
                Icon(
                  Icons.search_rounded,
                  color: AppColors.orTextColor,
                  size: 24,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // ── Featured card ───────────────────────────────────────
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _FeaturedCard(item: _featured),
          ),
          const SizedBox(height: 20),
          // ── Category chips ──────────────────────────────────────
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final cat = _categories[i];
                final selected = cat == _selectedCategory;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat),
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
              children: _filtered
                  .map((v) => _VideoCard(item: v))
                  .toList(),
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
  final _VideoItem item;

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
          // Background icon
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
  final _VideoItem item;

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
                    style: AppTextStyles.bold14.copyWith(fontSize: 13),
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
