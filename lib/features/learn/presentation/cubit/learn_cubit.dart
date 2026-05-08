import 'package:fit_flow/features/learn/domain/repo/learn_repo.dart';
import 'package:fit_flow/features/learn/presentation/cubit/learn_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LearnCubit extends Cubit<LearnState> {
  LearnCubit(LearnRepo repo) : super(_load(repo));

  static LearnState _load(LearnRepo repo) => LearnLoaded(
        featured: repo.getFeatured(),
        items: repo.getItems(),
        categories: repo.getCategories(),
        selectedCategory: 'All',
      );

  void selectCategory(String category) {
    final current = state;
    if (current is LearnLoaded) {
      emit(current.copyWith(selectedCategory: category));
    }
  }
}
