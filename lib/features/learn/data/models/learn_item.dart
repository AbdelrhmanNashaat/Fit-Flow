import 'package:flutter/material.dart';

class LearnItem {
  const LearnItem({
    required this.id,
    required this.title,
    required this.content,
    required this.channel,
    required this.duration,
    required this.category,
    required this.color,
    required this.icon,
    required this.videoUrl,
    required this.thumbnailUrl,
  });

  final String id;
  final String title;
  final String content;
  final String channel;
  final String duration;
  final String category;
  final Color color;
  final IconData icon;
  final String videoUrl;
  final String thumbnailUrl;
}
