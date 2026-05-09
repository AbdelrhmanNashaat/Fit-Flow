import 'dart:async';

import 'package:fit_flow/core/service/cache_helper.dart';
import 'package:fit_flow/core/utils/app_navigation.dart';
import 'package:fit_flow/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:fit_flow/features/auth/presentation/cubit/auth_session_state.dart';
import 'package:fit_flow/features/auth/presentation/views/create_account_view.dart';
import 'package:fit_flow/features/auth/presentation/views/forgot_password_view.dart';
import 'package:fit_flow/features/auth/presentation/views/sign_in_view.dart';
import 'package:fit_flow/features/locale/presentation/views/language_setup_view.dart';
import 'package:fit_flow/features/main/presentation/views/main_view.dart';
import 'package:fit_flow/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:fit_flow/features/splash/presentation/views/splash_view.dart';
import 'package:fit_flow/features/workout/presentation/models/active_exercise_args.dart';
import 'package:fit_flow/features/workout/presentation/views/active_exercise_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter(
  AuthSessionCubit authCubit,
  CacheHelper cacheHelper,
  ValueNotifier<int> languageSetupNotifier,
) {
  return GoRouter(
    initialLocation: AppNavigation.splash,
    refreshListenable: Listenable.merge([
      _AuthRefreshNotifier(authCubit.stream),
      languageSetupNotifier,
    ]),
    redirect: (_, state) =>
        _redirect(authCubit.state, state.uri.path, cacheHelper),
    routes: [
      GoRoute(
        path: AppNavigation.languageSetup,
        builder: (_, state) => LanguageSetupView(
          onLanguageSelected: () => languageSetupNotifier.value++,
        ),
      ),
      GoRoute(
        path: AppNavigation.splash,
        builder: (_, _) => const SplashView(),
      ),
      GoRoute(
        path: AppNavigation.signIn,
        builder: (_, _) => const SignInView(),
      ),
      GoRoute(
        path: AppNavigation.signUp,
        builder: (_, _) => const CreateAccountView(),
      ),
      GoRoute(
        path: AppNavigation.forgotPassword,
        builder: (_, _) => const ForgotPasswordView(),
      ),
      GoRoute(
        path: AppNavigation.onboarding,
        builder: (_, _) => const OnboardingView(),
      ),
      GoRoute(path: AppNavigation.home, builder: (_, _) => const MainView()),
      GoRoute(
        path: AppNavigation.activeExercise,
        builder: (_, state) =>
            ActiveExerciseView(args: state.extra! as ActiveExerciseArgs),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_rounded, size: 48),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => context.go(AppNavigation.splash),
              child: const Text('Go home'),
            ),
          ],
        ),
      ),
    ),
  );
}

String? _redirect(
  AuthSessionState authState,
  String location,
  CacheHelper cacheHelper,
) {
  // Language must be selected before anything else.
  if (!cacheHelper.hasLanguageBeenSelected) {
    return location == AppNavigation.languageSetup
        ? null
        : AppNavigation.languageSetup;
  }

  // Still resolving — keep showing splash.
  if (authState is AuthSessionChecking || authState is AuthSessionInitial) {
    return location == AppNavigation.splash ? null : AppNavigation.splash;
  }

  final isUnauthenticated =
      authState is AuthSessionUnauthenticated ||
      (authState is AuthSessionFailure && authState.user == null);

  final needsOnboarding = authState is AuthSessionNeedsOnboarding;

  final isAuthenticated =
      authState is AuthSessionAuthenticated ||
      authState is AuthSessionSigningOut ||
      authState is AuthSessionNeedsReauth ||
      (authState is AuthSessionFailure && authState.user != null);

  if (isUnauthenticated) {
    final onAuthScreen =
        location == AppNavigation.signIn ||
        location == AppNavigation.signUp ||
        location == AppNavigation.forgotPassword;
    return onAuthScreen ? null : AppNavigation.signIn;
  }

  if (needsOnboarding) {
    return location == AppNavigation.onboarding
        ? null
        : AppNavigation.onboarding;
  }

  if (isAuthenticated) {
    final onGate =
        location == AppNavigation.splash ||
        location == AppNavigation.signIn ||
        location == AppNavigation.signUp ||
        location == AppNavigation.forgotPassword ||
        location == AppNavigation.onboarding ||
        location == AppNavigation.languageSetup;
    return onGate ? AppNavigation.home : null;
  }

  return null;
}

// Notifies GoRouter whenever auth state changes so redirects re-evaluate.
final class _AuthRefreshNotifier extends ChangeNotifier {
  _AuthRefreshNotifier(Stream<dynamic> stream) {
    _sub = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _sub;

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
