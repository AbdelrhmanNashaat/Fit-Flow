# FitFlow — Claude Code Guide

## Project Overview
FitFlow is a Flutter fitness app with Firebase Auth, Firestore, local image storage, and a local workout plan engine. It supports English and Arabic (RTL) via a hand-rolled `AppLocalizations` class.

## Architecture
Feature-based Clean Architecture:
```
lib/
  core/
    config/          # AppConfig (env-specific values)
    errors/          # Failure, AuthException
    l10n/            # AppLocalizations (EN/AR, no codegen)
    service/         # AuthService, DatabaseService, CacheHelper, LocalImageService, ServiceLocator
    utils/           # AppColors, AppTextStyles, AppNavigation, AppAssets, AppValidators
    widgets/         # Shared widgets (CustomButton, CustomAppBar, CustomTextField)
  features/
    auth/            # Firebase Auth (sign-in, sign-up, Google, forgot password)
    home/            # Home dashboard (HomeCubit, workout overview)
    locale/          # LocaleCubit (EN/AR toggle, persisted to SharedPreferences)
    main/            # MainView (PersistentBottomNavBar, 3 tabs)
    onboarding/      # Goal selection, availability, recommendations
    splash/          # SplashView (session check)
    user_profile/    # ProfileCubit, profile settings, image picker
    workout/         # Models, WorkoutRepo, ActiveExerciseCubit, exercise screens
```

## State Management
- **Cubit** everywhere (no Bloc events unless genuinely needed).
- Sealed state classes with `switch` exhaustive matching in `BlocBuilder`.
- `MultiBlocListener` for side-effect handling in complex screens.
- `BlocProvider` is created at the **view** level; widgets are dumb.

## Dependency Injection
`get_it` via `setupServiceLocator()` in `lib/core/service/service_locator.dart`.
All singletons are registered with `registerLazySingleton`. Never call `getIt` inside a widget — inject via Cubit constructor only.

## Navigation
`AppNavigation` in `lib/core/utils/app_navigation.dart` — named routes only.
Route arguments are typed structs (e.g. `ActiveExerciseArgs`), never raw `Map`.

## Colors
All colors live in `AppColors` (`lib/core/utils/app_colors.dart`). Semantic naming:
- `backgroundScaffold`, `backgroundAppBar`, `backgroundCard`, `backgroundButton`
- `textPrimary`, `textSecondary`, `textTertiary`
- `borderColor`, `borderButton`, `borderLight`
- `dividerColor`, `dividerLight`
- `primaryColor`, `primaryNavSelected`, `primarySurface`, `buttonColor`
- `success`, `successLight`, `warning`, `warningLight`

Never use raw `Color(0x...)` outside `AppColors`.

## Localizations
`AppLocalizations` is hand-written in `lib/core/l10n/app_localizations.dart`.
- Add both `en` and `ar` strings to every getter.
- Use `context.l10n.yourKey` everywhere — never hardcode strings in widgets.
- Parameterized strings use regular Dart methods (e.g. `appVersion(String v)`).

## Workout Data
`WorkoutRepo` is a **synchronous** interface (no `Either`, no `Future`). Data is in-memory (`LocalWorkoutRepo` + `sample_workout_data.dart`). The Firestore structure exists for future cloud sync but is not wired yet.

## Key Conventions
- No comments except for non-obvious WHY.
- `const` constructors everywhere possible.
- `copyWith` on every state class that uses `emit(state.copyWith(...))`.
- Timer cleanup: always override `Cubit.close()` to cancel `Timer?`.
- Local profile images: stored in `getApplicationDocumentsDirectory()/profile_images/<uid>.jpg`, path persisted in SharedPreferences keyed `local_image_path_<uid>`.

## Running the App
```bash
flutter pub get
flutter run
```
Requires `lib/core/config/app_config.dart` with a valid `googleServerClientId`.
