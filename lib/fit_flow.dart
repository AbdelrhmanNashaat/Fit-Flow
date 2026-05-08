import 'dart:async';

import 'package:fit_flow/core/config/app_config.dart';
import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/router/app_router.dart';
import 'package:fit_flow/core/service/service_locator.dart';
import 'package:fit_flow/core/theme/app_theme.dart';
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
import 'package:go_router/go_router.dart';

class FitFlow extends StatefulWidget {
  const FitFlow({super.key});

  @override
  State<FitFlow> createState() => _FitFlowState();
}

class _FitFlowState extends State<FitFlow> {
  late final AuthSessionCubit _authSessionCubit;
  late final GoRouter _router;
  late final StreamSubscription<AuthSessionState> _splashSub;
  bool _nativeSplashRemoved = false;

  @override
  void initState() {
    super.initState();
    _authSessionCubit = AuthSessionCubit(
      getIt<AuthRepo>(),
      getIt<UserProfileRepo>(),
      getIt<CurrentWorkoutPlanRepo>(),
    );
    _router = createRouter(_authSessionCubit);
    _splashSub = _authSessionCubit.stream.listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(AuthSessionState state) {
    if (state is AuthSessionChecking || state is AuthSessionInitial) return;
    if (_nativeSplashRemoved) return;
    _nativeSplashRemoved = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) FlutterNativeSplash.remove();
    });
  }

  @override
  void dispose() {
    _splashSub.cancel();
    _authSessionCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<LocaleCubit>()),
        BlocProvider.value(value: _authSessionCubit),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp.router(
            routerConfig: _router,
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
            theme: AppTheme.light(),
          );
        },
      ),
    );
  }
}
