import 'package:fit_flow/core/config/app_config.dart';
import 'package:fit_flow/core/service/service_locator.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_navigation.dart';
import 'package:fit_flow/features/auth/data/repo/auth_repo.dart';
import 'package:fit_flow/features/splash/presentation/cubit/auth_session_cubit.dart';
import 'package:fit_flow/features/splash/presentation/cubit/auth_session_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class FitFlow extends StatefulWidget {
  const FitFlow({super.key});

  @override
  State<FitFlow> createState() => _FitFlowState();
}

class _FitFlowState extends State<FitFlow> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    _removeSplash();
  }

  void _removeSplash() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthSessionCubit(getIt<AuthRepo>())..checkAuthStatus(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        debugShowCheckedModeBanner: AppConfig.instance.showDebugBanner,
        title: AppConfig.instance.appName,
        initialRoute: AppNavigation.splash,
        routes: AppNavigation.routes,
        builder: (context, child) {
          return BlocListener<AuthSessionCubit, AuthSessionState>(
            listenWhen: (_, current) {
              return current is AuthSessionAuthenticated ||
                  current is AuthSessionUnauthenticated ||
                  (current is AuthSessionFailure && current.user == null);
            },
            listener: (context, state) {
              final navigator = _navigatorKey.currentState;
              if (navigator == null) return;

              if (state is AuthSessionAuthenticated) {
                navigator.pushNamedAndRemoveUntil(
                  AppNavigation.home,
                  (route) => false,
                );
              }

              if (state is AuthSessionUnauthenticated ||
                  (state is AuthSessionFailure && state.user == null)) {
                navigator.pushNamedAndRemoveUntil(
                  AppNavigation.signIn,
                  (route) => false,
                );
              }
            },
            child: child ?? const SizedBox.shrink(),
          );
        },
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
