import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flow/core/config/app_config.dart';
import 'package:fit_flow/core/service/auth_service.dart';
import 'package:fit_flow/core/service/cache_helper.dart';
import 'package:fit_flow/core/service/firebase_auth_service.dart';
import 'package:fit_flow/features/auth/data/repo/auth_repo_impl.dart';
import 'package:fit_flow/features/auth/domain/repo/auth_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator({required SharedPreferences sharedPreferences}) {
  if (!getIt.isRegistered<SharedPreferences>()) {
    getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  }

  if (!getIt.isRegistered<CacheHelper>()) {
    getIt.registerLazySingleton<CacheHelper>(
      () => CacheHelper(getIt<SharedPreferences>()),
    );
  }

  if (!getIt.isRegistered<GoogleSignIn>()) {
    getIt.registerLazySingleton<GoogleSignIn>(
      () =>
          GoogleSignIn(serverClientId: AppConfig.instance.googleServerClientId),
    );
  }

  if (!getIt.isRegistered<AuthService>()) {
    getIt.registerLazySingleton<AuthService>(
      () => FirebaseAuthService(
        auth: FirebaseAuth.instance,
        googleSignIn: getIt<GoogleSignIn>(),
      ),
    );
  }

  if (!getIt.isRegistered<AuthRepo>()) {
    getIt.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(getIt<AuthService>(), getIt<CacheHelper>()),
    );
  }
}
