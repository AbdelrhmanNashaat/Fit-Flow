import 'package:fit_flow/features/learn/data/models/learn_item.dart';
import 'package:fit_flow/features/learn/domain/repo/learn_repo.dart';
import 'package:flutter/material.dart';

class LocalLearnRepo implements LearnRepo {
  const LocalLearnRepo();

  static const LearnItem _featured = LearnItem(
    title: 'How to Perfect Your Squat Form',
    channel: 'FitFlow Academy',
    duration: '12:34',
    category: 'Technique',
    color: Color(0xFF1A3FAB),
    icon: Icons.play_circle_fill_rounded,
  );

  static const List<LearnItem> _items = [
    LearnItem(
      title: 'Progressive Overload Explained',
      channel: 'Strength Science',
      duration: '08:21',
      category: 'Technique',
      color: Color(0xFF2563EB),
      icon: Icons.fitness_center_rounded,
    ),
    LearnItem(
      title: 'Pre-Workout Nutrition Timing',
      channel: 'FitFlow Academy',
      duration: '06:45',
      category: 'Nutrition',
      color: Color(0xFF22C55E),
      icon: Icons.restaurant_rounded,
    ),
    LearnItem(
      title: 'Sleep & Muscle Recovery',
      channel: 'Recovery Lab',
      duration: '10:12',
      category: 'Recovery',
      color: Color(0xFF8B5CF6),
      icon: Icons.bedtime_rounded,
    ),
    LearnItem(
      title: 'Bench Press — Full Tutorial',
      channel: 'Strength Science',
      duration: '15:07',
      category: 'Technique',
      color: Color(0xFFF59E0B),
      icon: Icons.sports_gymnastics_rounded,
    ),
    LearnItem(
      title: 'Protein Intake for Muscle Growth',
      channel: 'FitFlow Academy',
      duration: '09:30',
      category: 'Nutrition',
      color: Color(0xFFEF4444),
      icon: Icons.egg_alt_rounded,
    ),
    LearnItem(
      title: 'Foam Rolling: Do It Right',
      channel: 'Recovery Lab',
      duration: '07:55',
      category: 'Recovery',
      color: Color(0xFF14B8A6),
      icon: Icons.self_improvement_rounded,
    ),
    LearnItem(
      title: 'Building a Winning Mindset',
      channel: 'Mind Over Muscle',
      duration: '11:20',
      category: 'Mindset',
      color: Color(0xFFEC4899),
      icon: Icons.psychology_rounded,
    ),
  ];

  static const List<String> _categories = [
    'All',
    'Technique',
    'Nutrition',
    'Recovery',
    'Mindset',
  ];

  @override
  LearnItem getFeatured() => _featured;

  @override
  List<LearnItem> getItems() => _items;

  @override
  List<String> getCategories() => _categories;
}
