import 'dart:async';
import 'package:fit_flow/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:fit_flow/features/auth/presentation/cubit/auth_session_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class NativeSplashController {
  NativeSplashController._();

  static StreamSubscription<AuthSessionState>? _subscription;

  static bool _isSplashRemoved = false;

  static void bind(AuthSessionCubit cubit) {
    _subscription?.cancel();

    _subscription = cubit.stream.listen((state) {
      if (state is AuthSessionInitial || state is AuthSessionChecking) {
        return;
      }

      _removeSplash();
    });
  }

  static void dispose() {
    _subscription?.cancel();
  }

  static void _removeSplash() {
    if (_isSplashRemoved) {
      return;
    }

    _isSplashRemoved = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
  }
}
