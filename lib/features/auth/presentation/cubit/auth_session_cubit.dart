import 'dart:async';

import 'package:fit_flow/core/errors/failure.dart';
import 'package:fit_flow/features/auth/data/model/auth_user.dart';
import 'package:fit_flow/features/auth/domain/repo/auth_repo.dart';
import 'package:fit_flow/features/auth/presentation/cubit/auth_session_state.dart';
import 'package:fit_flow/features/user_profile/data/model/user_profile.dart';
import 'package:fit_flow/features/user_profile/domain/repo/user_profile_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthSessionCubit extends Cubit<AuthSessionState> {
  AuthSessionCubit(
    this._authRepo,
    this._userProfileRepo,
  ) : super(const AuthSessionChecking()) {
    _authStateSubscription = _authRepo.authStateChanges().listen(
      _onAuthStateChanged,
      onError: _onAuthStreamError,
    );
  }

  final AuthRepo _authRepo;
  final UserProfileRepo _userProfileRepo;

  late final StreamSubscription<AuthUser?> _authStateSubscription;

  /// Set to true during explicit sign-out / account-deletion to prevent
  /// the Firebase authStateChanges null event from double-emitting.
  bool _isTransitioning = false;

  AuthUser? get _currentUser => switch (state) {
    AuthSessionAuthenticated(:final user) => user,
    AuthSessionSigningOut(:final user) => user,
    AuthSessionNeedsOnboarding(:final user) => user,
    AuthSessionNeedsReauth(:final user) => user,
    AuthSessionFailure(:final user?) => user,
    _ => null,
  };

  @override
  Future<void> close() {
    _authStateSubscription.cancel();
    return super.close();
  }

  void _onAuthStateChanged(AuthUser? user) {
    if (state is AuthSessionSigningOut || _isTransitioning) return;

    if (user == null) {
      emit(const AuthSessionUnauthenticated());
    } else {
      _resolveUserDestination(user);
    }
  }

  void _onAuthStreamError(Object error) {
    emit(AuthSessionFailure(error.toString()));
  }

  void setOnboardingCompleted(AuthUser user) {
    emit(AuthSessionAuthenticated(user));
  }

  Future<void> signOut() async {
    final user = _currentUser;
    if (user != null) emit(AuthSessionSigningOut(user));

    final result = await _authRepo.signOut();
    result.fold(
      (failure) => emit(AuthSessionFailure(failure.message, user: user)),
      (_) => emit(const AuthSessionUnauthenticated()),
    );
  }

  /// Resets onboarding in Firestore and sends the user back to the goal-selection flow.
  Future<void> resetAndStartOnboarding() async {
    final user = _currentUser;
    if (user == null) return;

    final result = await _userProfileRepo.updateProfile(user.id, {
      'isOnboardingCompleted': false,
    });
    result.fold(
      (failure) => emit(AuthSessionFailure(failure.message, user: user)),
      (_) => emit(AuthSessionNeedsOnboarding(user)),
    );
  }

  /// Permanently deletes the Firebase Auth account and Firestore document.
  ///
  /// On [ReauthRequiredFailure] (email users only), emits [AuthSessionNeedsReauth]
  /// so the UI can prompt for the password and retry with [password] supplied.
  Future<void> deleteAccount({String? password}) async {
    final user = _currentUser;
    if (user == null) return;

    _isTransitioning = true;
    final authResult = await _authRepo.deleteAccount(password: password);
    await authResult.fold(
      (failure) async {
        _isTransitioning = false;
        if (failure is ReauthRequiredFailure) {
          emit(AuthSessionNeedsReauth(user, failure.provider));
        } else {
          emit(AuthSessionFailure(failure.message, user: user));
        }
      },
      (_) async {
        // Best-effort Firestore cleanup — ignore errors so Auth deletion is not blocked.
        await _userProfileRepo.deleteProfile(user.id);
        _isTransitioning = false;
        emit(const AuthSessionUnauthenticated());
      },
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
      name: user.name.isNotEmpty ? user.name : null,
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
