import 'package:fit_flow/core/service/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(this._cacheHelper) : super(_initialLocale(_cacheHelper));

  final CacheHelper _cacheHelper;

  static Locale _initialLocale(CacheHelper cache) {
    final saved = cache.savedLocale;
    return saved != null ? Locale(saved) : const Locale('en');
  }

  Future<void> setLocale(String languageCode) async {
    await _cacheHelper.saveLocale(languageCode);
    emit(Locale(languageCode));
  }
}
