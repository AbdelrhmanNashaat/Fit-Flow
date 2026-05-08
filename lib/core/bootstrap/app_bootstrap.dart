import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fit_flow/core/service/service_locator.dart';

class AppBootstrap {
  static Future<void> init() async {
    await Firebase.initializeApp();
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
    final sharedPreferences = await SharedPreferences.getInstance();
    setupServiceLocator(sharedPreferences: sharedPreferences);
  }
}
