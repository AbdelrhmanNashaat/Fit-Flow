import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Splash screen renders branded startup content', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: SplashView(),
      ),
    );

    await tester.pump(const Duration(milliseconds: 950));

    expect(find.text('FitFlow'), findsOneWidget);
    expect(find.text('Elevate Your Movement'), findsOneWidget);
  });
}
