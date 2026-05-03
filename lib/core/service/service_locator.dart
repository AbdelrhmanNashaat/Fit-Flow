import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/repo/auth_repo.dart';
import '../../features/auth/data/repo/auth_repo_impl.dart';
import 'firebase_service.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<FirebaseService>(
    () => FirebaseService(auth: FirebaseAuth.instance),
  );
  getIt.registerLazySingleton<FireBaseAuthRepo>(
    () => FirebaseAuthRepoImpl(firebaseService: getIt<FirebaseService>()),
  );
}
