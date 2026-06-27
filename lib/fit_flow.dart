import 'package:fit_flow/core/config/app_config.dart';
import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/router/app_router.dart';
import 'package:fit_flow/core/service/cache_helper.dart';
import 'package:fit_flow/core/service/service_locator.dart';
import 'package:fit_flow/core/startup/native_splash_controller.dart';
import 'package:fit_flow/core/theme/app_theme.dart';
import 'package:fit_flow/features/auth/domain/repo/auth_repo.dart';
import 'package:fit_flow/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:fit_flow/features/locale/cubit/locale_cubit.dart';
import 'package:fit_flow/features/user_profile/domain/repo/user_profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

class FitFlow extends StatefulWidget {
  const FitFlow({super.key});

  @override
  State<FitFlow> createState() => _FitFlowState();
}

class _FitFlowState extends State<FitFlow> {
  late final AuthSessionCubit _authSessionCubit;
  late final GoRouter _router;

  final _localeSetupRefreshNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _authSessionCubit = _createAuthSessionCubit();

    _router = createRouter(
      _authSessionCubit,
      getIt<CacheHelper>(),
      _localeSetupRefreshNotifier,
    );

    NativeSplashController.bind(_authSessionCubit);
  }

  AuthSessionCubit _createAuthSessionCubit() {
    return AuthSessionCubit(
      getIt<AuthRepo>(),
      getIt<UserProfileRepo>(),
    );
  }

  @override
  void dispose() {
    _authSessionCubit.close();
    _localeSetupRefreshNotifier.dispose();
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
        builder: (_, locale) {
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
