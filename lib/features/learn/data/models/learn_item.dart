import 'package:flutter/material.dart';

class LearnItem {
  const LearnItem({
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
