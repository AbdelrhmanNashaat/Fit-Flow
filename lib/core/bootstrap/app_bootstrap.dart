import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fit_flow/core/config/app_environment.dart';
import 'package:fit_flow/core/service/cache_helper.dart';

import 'package:fit_flow/core/service/service_locator.dart';

class AppBootstrap {
  static Future<void> init() async {
    await AppEnvironment.load();
    await Firebase.initializeApp();
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
    final cacheHelper = await CacheHelper.init();
    setupServiceLocator(cacheHelper: cacheHelper);
  }
}
