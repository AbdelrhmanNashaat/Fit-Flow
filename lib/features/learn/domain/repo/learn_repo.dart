import 'package:fit_flow/features/learn/data/models/learn_feed_model.dart';

abstract interface class LearnRepo {
  Future<LearnFeedModel> loadFeed();
}
