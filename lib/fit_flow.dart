import 'package:fit_flow/core/config/app_config.dart';
import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/service/service_locator.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_navigation.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/features/auth/domain/repo/auth_repo.dart';
import 'package:fit_flow/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:fit_flow/features/auth/presentation/cubit/auth_session_state.dart';
import 'package:fit_flow/features/locale/cubit/locale_cubit.dart';
import 'package:fit_flow/features/user_profile/domain/repo/user_profile_repo.dart';
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
          create: (_) =>
              AuthSessionCubit(getIt<AuthRepo>(), getIt<UserProfileRepo>())
                ..checkAuthStatus(),
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
            theme: ThemeData(
              useMaterial3: true,
              fontFamily: 'Inter',
              scaffoldBackgroundColor: AppColors.backgroundScaffold,
              colorScheme: const ColorScheme.light(
                primary: AppColors.primaryColor,
                onPrimary: AppColors.whiteColor,
                secondary: AppColors.primaryNavSelected,
                onSecondary: AppColors.whiteColor,
                error: AppColors.error,
                onError: AppColors.whiteColor,
                surface: AppColors.backgroundScaffold,
                onSurface: AppColors.textPrimary,
              ),
              textTheme: const TextTheme(
                displayLarge: AppTextStyles.bold48,
                displayMedium: AppTextStyles.extraBold30,
                displaySmall: AppTextStyles.extraBold26,
                headlineLarge: AppTextStyles.bold26,
                headlineMedium: AppTextStyles.bold20,
                headlineSmall: AppTextStyles.bold18,
                titleLarge: AppTextStyles.bold16,
                titleMedium: AppTextStyles.medium14,
                titleSmall: AppTextStyles.semiBold12,
                bodyLarge: AppTextStyles.regular17,
                bodyMedium: AppTextStyles.regular16,
                bodySmall: AppTextStyles.regular14,
                labelLarge: AppTextStyles.bold14,
                labelMedium: AppTextStyles.medium12,
                labelSmall: AppTextStyles.regular12,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  foregroundColor: AppColors.whiteColor,
                  textStyle: AppTextStyles.bold14,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: AppColors.backgroundButton,
                hintStyle: AppTextStyles.regular14.copyWith(
                  color: AppColors.hintTextColor,
                ),
                labelStyle: AppTextStyles.medium14.copyWith(
                  color: AppColors.textPrimary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                    width: 1.5,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.error),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.error,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
