import 'package:fit_flow/features/splash/presentation/views/splash_view.dart';
import 'package:fit_flow/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Splash screen renders branded startup content', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: const SplashView(),
      ),
    );

    await tester.pump(const Duration(milliseconds: 950));

    expect(find.text('FitFlow'), findsOneWidget);
    expect(find.text('Elevate Your Movement'), findsOneWidget);
  });
}
