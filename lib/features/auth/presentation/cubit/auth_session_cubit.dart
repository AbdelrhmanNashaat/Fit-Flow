import 'package:fit_flow/features/auth/data/model/auth_user.dart';
import 'package:fit_flow/features/auth/domain/repo/auth_repo.dart';
import 'package:fit_flow/features/auth/presentation/cubit/auth_session_state.dart';
import 'package:fit_flow/features/user_profile/data/model/user_profile.dart';
import 'package:fit_flow/features/user_profile/domain/repo/user_profile_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthSessionCubit extends Cubit<AuthSessionState> {
  AuthSessionCubit(this._authRepo, this._userProfileRepo)
      : super(const AuthSessionInitial());

  final AuthRepo _authRepo;
  final UserProfileRepo _userProfileRepo;

  Future<void> checkAuthStatus() async {
    emit(const AuthSessionChecking());
    final result = await _authRepo.restoreSession();
    result.fold(
      (failure) => emit(AuthSessionFailure(failure.message)),
      (user) => user == null
          ? emit(const AuthSessionUnauthenticated())
          : _resolveUserDestination(user),
    );
  }

  Future<void> setAuthenticated(AuthUser user) async {
    emit(const AuthSessionChecking());
    await _resolveUserDestination(user);
  }

  void setOnboardingCompleted(AuthUser user) {
    emit(AuthSessionAuthenticated(user));
  }

  Future<void> signOut() async {
    final currentUser = switch (state) {
      AuthSessionSigningOut(:final user) => user,
      AuthSessionAuthenticated(:final user) => user,
      AuthSessionNeedsOnboarding(:final user) => user,
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

  Future<void> _resolveUserDestination(AuthUser user) async {
    final result = await _userProfileRepo.getProfile(user.id);
    result.fold(
      (failure) => emit(AuthSessionFailure(failure.message, user: user)),
      (profile) async {
        if (profile == null) {
          await _createProfileAndProceedToOnboarding(user);
        } else if (profile.isOnboardingCompleted) {
          emit(AuthSessionAuthenticated(user));
        } else {
          emit(AuthSessionNeedsOnboarding(user));
        }
      },
    );
  }

  Future<void> _createProfileAndProceedToOnboarding(AuthUser user) async {
    final newProfile = UserProfile(
      uid: user.id,
      email: user.email,
      isOnboardingCompleted: false,
      createdAt: DateTime.now(),
    );
    final result = await _userProfileRepo.createProfile(newProfile);
    result.fold(
      (failure) => emit(AuthSessionFailure(failure.message, user: user)),
      (_) => emit(AuthSessionNeedsOnboarding(user)),
    );
  }
}
