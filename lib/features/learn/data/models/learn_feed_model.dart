import 'package:fit_flow/features/learn/data/models/learn_item.dart';

class LearnFeedModel {
  const LearnFeedModel({
    required this.featured,
    required this.items,
    required this.categories,
    required this.allCategory,
  });

  final LearnItem featured;
  final List<LearnItem> items;
  final List<String> categories;
  final String allCategory;
}