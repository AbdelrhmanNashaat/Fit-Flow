import 'package:fit_flow/features/learn/domain/repo/learn_repo.dart';
import 'package:fit_flow/features/learn/presentation/cubit/learn_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LearnCubit extends Cubit<LearnState> {
  LearnCubit(this._repo) : super(const LearnLoading()) {
    load();
  }

  final LearnRepo _repo;

  Future<void> load() async {
    emit(const LearnLoading());
    try {
      final feed = await _repo.loadFeed();
      emit(
        LearnLoaded(
          featured: feed.featured,
          items: feed.items,
          categories: feed.categories,
          allCategory: feed.allCategory,
          selectedCategory: feed.allCategory,
        ),
      );
    } catch (error) {
      emit(LearnError(error.toString().replaceFirst('Exception: ', '')));
    }
  }

  void selectCategory(String category) {
    final current = state;
    if (current is LearnLoaded) {
      emit(current.copyWith(selectedCategory: category));
    }
  }
}
