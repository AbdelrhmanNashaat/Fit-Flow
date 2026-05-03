import 'package:firebase_core/firebase_core.dart';

import '../service/service_locator.dart';

class AppBootstrap {
  static Future<void> init() async {
    await Firebase.initializeApp();
    setupServiceLocator();
  }
}
