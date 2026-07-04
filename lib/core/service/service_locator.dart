import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flow/core/config/app_config.dart';
import 'package:fit_flow/core/service/auth_service.dart';
import 'package:fit_flow/core/service/cache_helper.dart';
import 'package:fit_flow/core/service/database_service.dart';
import 'package:fit_flow/core/service/firebase_auth_service.dart';
import 'package:fit_flow/core/service/fire_store_storage_service.dart';
import 'package:fit_flow/core/service/local_image_service.dart';
import 'package:fit_flow/core/service/local_image_service_impl.dart';
import 'package:fit_flow/features/auth/data/repo/auth_repo_impl.dart';
import 'package:fit_flow/features/auth/domain/repo/auth_repo.dart';
import 'package:fit_flow/features/locale/cubit/locale_cubit.dart';
import 'package:fit_flow/features/user_profile/data/repo/user_profile_repo_impl.dart';
import 'package:fit_flow/features/user_profile/domain/repo/user_profile_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator({required CacheHelper cacheHelper}) {
  if (!getIt.isRegistered<CacheHelper>()) {
    getIt.registerLazySingleton<CacheHelper>(() => cacheHelper);
  }

  if (!getIt.isRegistered<FirebaseFirestore>()) {
    getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );
  }

  if (!getIt.isRegistered<GoogleSignIn>()) {
    getIt.registerLazySingleton<GoogleSignIn>(
      () => AppConfig.hasGoogleServerClientId
          ? GoogleSignIn(serverClientId: AppConfig.googleServerClientId)
          : GoogleSignIn(),
    );
  }

  if (!getIt.isRegistered<AuthService>()) {
    getIt.registerLazySingleton<AuthService>(
      () => FirebaseAuthService(
        auth: FirebaseAuth.instance,
        googleSignIn: getIt<GoogleSignIn>(),
        cacheHelper: getIt<CacheHelper>(),
      ),
    );
  }

  if (!getIt.isRegistered<DatabaseService>()) {
    getIt.registerLazySingleton<DatabaseService>(
      () => FirestoreService(getIt<FirebaseFirestore>()),
    );
  }

  if (!getIt.isRegistered<ImagePicker>()) {
    getIt.registerLazySingleton<ImagePicker>(() => ImagePicker());
  }

  if (!getIt.isRegistered<LocalImageService>()) {
    getIt.registerLazySingleton<LocalImageService>(
      () => const LocalImageServiceImpl(),
    );
  }

  if (!getIt.isRegistered<AuthRepo>()) {
    getIt.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(getIt<AuthService>()),
    );
  }

  if (!getIt.isRegistered<UserProfileRepo>()) {
    getIt.registerLazySingleton<UserProfileRepo>(
      () => UserProfileRepoImpl(
        getIt<DatabaseService>(),
        getIt<LocalImageService>(),
        getIt<CacheHelper>(),
      ),
    );
  }

  if (!getIt.isRegistered<LocaleCubit>()) {
    getIt.registerLazySingleton<LocaleCubit>(
      () => LocaleCubit(getIt<CacheHelper>()),
    );
  }
}
