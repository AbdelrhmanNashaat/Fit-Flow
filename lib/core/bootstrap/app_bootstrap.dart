import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fit_flow/core/config/app_config.dart';
import 'package:fit_flow/core/config/app_environment.dart';
import 'package:fit_flow/core/config/app_flavor.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fit_flow/core/service/service_locator.dart';

class AppBootstrap {
  static const _secureStorage = FlutterSecureStorage();

  static Future<void> init({required AppFlavor flavor}) async {
    await AppEnvironment.load();
    AppConfig.setup(flavor);
    await Firebase.initializeApp();
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
    final sharedPreferences = await SharedPreferences.getInstance();
    setupServiceLocator(
      sharedPreferences: sharedPreferences,
      secureStorage: _secureStorage,
    );
  }
}
