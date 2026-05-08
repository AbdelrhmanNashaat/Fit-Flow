import 'package:fit_flow/features/learn/data/models/learn_item.dart';

abstract interface class LearnRepo {
  LearnItem getFeatured();
  List<LearnItem> getItems();
  List<String> getCategories();
}
