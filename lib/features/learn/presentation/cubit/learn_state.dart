import 'package:fit_flow/features/learn/data/models/learn_item.dart';

sealed class LearnState {
  const LearnState();
}

final class LearnLoading extends LearnState {
  const LearnLoading();
}

final class LearnError extends LearnState {
  const LearnError(this.message);

  final String message;
}

final class LearnLoaded extends LearnState {
  const LearnLoaded({
    required this.featured,
    required this.items,
    required this.categories,
    required this.allCategory,
    required this.selectedCategory,
  });

  final LearnItem featured;
  final List<LearnItem> items;
  final List<String> categories;
  final String allCategory;
  final String selectedCategory;

  List<LearnItem> get filtered => selectedCategory == allCategory
      ? items
      : items.where((v) => v.category == selectedCategory).toList();

  LearnLoaded copyWith({String? selectedCategory}) => LearnLoaded(
        featured: featured,
        items: items,
        categories: categories,
        allCategory: allCategory,
        selectedCategory: selectedCategory ?? this.selectedCategory,
      );
}
