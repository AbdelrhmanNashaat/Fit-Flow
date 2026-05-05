import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flow/core/service/auth_service.dart';
import 'package:fit_flow/core/service/firebase_auth_service.dart';
import 'package:fit_flow/features/auth/data/repo/auth_repo.dart';
import 'package:fit_flow/features/auth/data/repo/auth_repo_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  getIt.registerLazySingleton<AuthService>(
    () => FirebaseAuthService(
      auth: FirebaseAuth.instance,
      googleSignIn: getIt<GoogleSignIn>(),
    ),
  );

  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(getIt<AuthService>()),
  );
}
