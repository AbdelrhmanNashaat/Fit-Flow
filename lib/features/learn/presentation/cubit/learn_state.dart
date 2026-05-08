import 'package:fit_flow/features/learn/data/models/learn_item.dart';

sealed class LearnState {
  const LearnState();
}

final class LearnLoaded extends LearnState {
  const LearnLoaded({
    required this.featured,
    required this.items,
    required this.categories,
    required this.selectedCategory,
  });

  final LearnItem featured;
  final List<LearnItem> items;
  final List<String> categories;
  final String selectedCategory;

  List<LearnItem> get filtered => selectedCategory == 'All'
      ? items
      : items.where((v) => v.category == selectedCategory).toList();

  LearnLoaded copyWith({String? selectedCategory}) => LearnLoaded(
        featured: featured,
        items: items,
        categories: categories,
        selectedCategory: selectedCategory ?? this.selectedCategory,
      );
}
