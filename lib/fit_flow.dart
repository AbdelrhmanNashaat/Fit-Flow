import 'package:fit_flow/core/config/app_config.dart';
import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/service/service_locator.dart';
import 'package:fit_flow/core/theme/app_theme.dart';
import 'package:fit_flow/core/utils/app_navigation.dart';
import 'package:fit_flow/features/auth/domain/repo/auth_repo.dart';
import 'package:fit_flow/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:fit_flow/features/auth/presentation/cubit/auth_session_state.dart';
import 'package:fit_flow/features/locale/cubit/locale_cubit.dart';
import 'package:fit_flow/features/user_profile/domain/repo/user_profile_repo.dart';
import 'package:fit_flow/features/workout/domain/repo/current_workout_plan_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class FitFlow extends StatefulWidget {
  const FitFlow({super.key});

  @override
  State<FitFlow> createState() => _FitFlowState();
}

class _FitFlowState extends State<FitFlow> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  bool _didRemoveNativeSplash = false;

  void _removeNativeSplash() {
    if (_didRemoveNativeSplash) {
      return;
    }

    _didRemoveNativeSplash = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      FlutterNativeSplash.remove();
    });
  }

  void _handleSessionState(AuthSessionState state) {
    _removeNativeSplash();

    final navigator = _navigatorKey.currentState;
    if (navigator == null) {
      return;
    }

    final routeName = switch (state) {
      AuthSessionAuthenticated() => AppNavigation.home,
      AuthSessionNeedsOnboarding() => AppNavigation.onboarding,
      AuthSessionUnauthenticated() => AppNavigation.signIn,
      AuthSessionFailure() =>
        state.user == null ? AppNavigation.signIn : AppNavigation.home,
      _ => null,
    };

    if (routeName == null) {
      return;
    }

    navigator.pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<LocaleCubit>()),
        BlocProvider(
          create: (_) => AuthSessionCubit(
            getIt<AuthRepo>(),
            getIt<UserProfileRepo>(),
            getIt<CurrentWorkoutPlanRepo>(),
          ),
        ),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            navigatorKey: _navigatorKey,
            debugShowCheckedModeBanner: AppConfig.instance.showDebugBanner,
            title: AppConfig.instance.appName,
            locale: locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            initialRoute: AppNavigation.splash,
            routes: AppNavigation.routes,
            builder: (context, child) {
              return BlocListener<AuthSessionCubit, AuthSessionState>(
                listenWhen: (_, current) {
                  return current is AuthSessionAuthenticated ||
                      current is AuthSessionNeedsOnboarding ||
                      current is AuthSessionUnauthenticated ||
                      current is AuthSessionFailure;
                },
                listener: (_, state) => _handleSessionState(state),
                child: child,
              );
            },
            theme: AppTheme.light(),
          );
        },
      ),
    );
  }
}
