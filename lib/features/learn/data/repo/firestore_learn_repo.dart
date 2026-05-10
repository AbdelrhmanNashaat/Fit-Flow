import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_flow/core/service/cache_helper.dart';
import 'package:fit_flow/features/learn/data/models/learn_feed_model.dart';
import 'package:fit_flow/features/learn/data/models/learn_item.dart';
import 'package:fit_flow/features/learn/domain/repo/learn_repo.dart';
import 'package:flutter/material.dart';

class FirestoreLearnRepo implements LearnRepo {
  const FirestoreLearnRepo(this._firestore, this._cacheHelper);

  final FirebaseFirestore _firestore;
  final CacheHelper _cacheHelper;

  @override
  Future<LearnFeedModel> loadFeed() async {
    final localeCode = _localeCode;
    final snapshot = await _firestore.collection('learn').get();
    final items = snapshot.docs
        .map((doc) => _toLearnItem(doc.id, doc.data(), localeCode))
        .toList()
      ..sort((left, right) => left.title.compareTo(right.title));

    if (items.isEmpty) {
      throw Exception('No learn content found in Firestore.');
    }

    final allCategory = localeCode == 'ar' ? 'الكل' : 'All';
    final categories = <String>{allCategory};
    for (final item in items) {
      categories.add(item.category);
    }

    return LearnFeedModel(
      featured: items.first,
      items: items,
      categories: categories.toList(growable: false),
      allCategory: allCategory,
    );
  }

  String get _localeCode => _cacheHelper.savedLocale == 'ar' ? 'ar' : 'en';

  LearnItem _toLearnItem(
    String id,
    Map<String, dynamic> data,
    String localeCode,
  ) {
    final englishCategory = _localizedText(data['category'], 'en');
    final category = _localizedText(data['category'], localeCode);
    final videoUrl = (data['videoUrl'] as String?) ?? '';
    final thumbnailUrl = (data['thumbnailUrl'] as String?) ?? '';
    final style = _styleForCategory(englishCategory);

    return LearnItem(
      id: id,
      title: _localizedText(data['title'], localeCode),
      content: _localizedText(data['content'], localeCode),
      channel: videoUrl.isNotEmpty
          ? 'YouTube'
          : (localeCode == 'ar' ? 'تعلّم' : 'Learn'),
      duration: videoUrl.isNotEmpty
          ? (localeCode == 'ar' ? 'شاهد الآن' : 'Watch now')
          : (localeCode == 'ar' ? 'اقرأ الآن' : 'Read now'),
      category: category,
      color: style.color,
      icon: style.icon,
      videoUrl: videoUrl,
      thumbnailUrl: thumbnailUrl,
    );
  }

  String _localizedText(dynamic value, String localeCode) {
    if (value is Map<String, dynamic>) {
      return (value[localeCode] as String?) ??
          (value['en'] as String?) ??
          (value['ar'] as String?) ??
          '';
    }
    return value?.toString() ?? '';
  }

  ({Color color, IconData icon}) _styleForCategory(String englishCategory) {
    switch (englishCategory.toLowerCase()) {
      case 'nutrition':
        return (color: const Color(0xFFEF8B47), icon: Icons.restaurant_menu_rounded);
      case 'recovery':
        return (color: const Color(0xFF4FAE7F), icon: Icons.nightlight_round);
      default:
        return (color: const Color(0xFF4F7CFF), icon: Icons.fitness_center_rounded);
    }
  }
}