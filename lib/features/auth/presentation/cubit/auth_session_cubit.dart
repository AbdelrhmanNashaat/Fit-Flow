import 'package:fit_flow/features/auth/data/model/auth_user.dart';
import 'package:fit_flow/features/auth/domain/repo/auth_repo.dart';
import 'package:fit_flow/features/auth/presentation/cubit/auth_session_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthSessionCubit extends Cubit<AuthSessionState> {
  AuthSessionCubit(this._authRepo) : super(const AuthSessionInitial());

  final AuthRepo _authRepo;

  Future<void> checkAuthStatus() async {
    emit(const AuthSessionChecking());
    final result = await _authRepo.restoreSession();
    result.fold(
      (failure) => emit(AuthSessionFailure(failure.message)),
      (user) => user == null
          ? emit(const AuthSessionUnauthenticated())
          : emit(AuthSessionAuthenticated(user)),
    );
  }

  void setAuthenticated(AuthUser user) {
    emit(AuthSessionAuthenticated(user));
  }

  Future<void> signOut() async {
    final currentUser = switch (state) {
      AuthSessionSigningOut(:final user) => user,
      AuthSessionAuthenticated(:final user) => user,
      AuthSessionFailure(:final user?) => user,
      _ => null,
    };

    if (currentUser != null) {
      emit(AuthSessionSigningOut(currentUser));
    }

    final result = await _authRepo.signOut();
    result.fold(
      (failure) => emit(AuthSessionFailure(failure.message, user: currentUser)),
      (_) => emit(const AuthSessionUnauthenticated()),
    );
  }
}
