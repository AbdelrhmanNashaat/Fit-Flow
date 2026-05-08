# Clean Code Review — FitFlow

## File Size Analysis

Files exceeding 150 lines (sorted by size):

| File | Lines | Assessment |
|---|---|---|
| `learn_view.dart` | 392 | **Critical** — all static mock data, no Cubit, no l10n |
| `profile_settings_view_body.dart` | 268 | **Warning** — multiple dialogs inline |
| `sample_workout_data.dart` | 211 | Acceptable — pure data definitions |
| `app_localizations.dart` | 205 | Acceptable — grows with strings |
| `active_exercise_view.dart` | 195 | **Warning** — complex BlocConsumer with dialogs |
| `forgot_password_view_body.dart` | 188 | Borderline — heavy nesting |
| `firebase_auth_service.dart` | 175 | Acceptable — complex auth flows |
| `home_view_body.dart` | 170 | Borderline |
| `active_workout_card.dart` | 169 | Acceptable — complex card UI |
| `active_exercise_cubit.dart` | 167 | Acceptable — inherently complex |

---

## Critical: `learn_view.dart` (392 lines)

**This is the worst file in the codebase.** Problems:

1. **No Cubit**: `LearnView` uses `StatefulWidget` with local `setState` — inconsistent with every other feature.
2. **Static hardcoded data**: `_VideoItem`, `_categories`, `_featured`, and `_videos` are all const data defined at the top of the view file. This data belongs in a repository or at minimum a separate data file.
3. **No localization**: The title "Learn" is hardcoded as a string literal in the widget. All other screens use `context.l10n`.
4. **Raw color literals**: Multiple `Color(0xFF...)` values used directly without `AppColors` tokens (`Color(0xFF1A3FAB)`, `Color(0xFF2563EB)`, `Color(0xFF22C55E)`, etc.).
5. **No tap handling**: Video cards have a chevron icon but `onTap` does nothing.
6. **Architecture abandonment**: The feature has no domain layer, no data layer, no repository — it is a UI prototype masquerading as a feature.

---

## `profile_settings_view_body.dart` (268 lines)

Contains three inline `showDialog` methods (`_confirmSignOut`, `_confirmReset`, `_confirmDeleteAccount`) and one `_showReauthDialog`. These are dialog-builder methods defined inside private classes in the widget file. Issues:

1. **Inline dialog builders are untestable** — they create and manage `TextEditingController` inline without lifecycle management (no `dispose`).
2. **The `_showReauthDialog` method creates a `TextEditingController` but never disposes it** — this is a memory leak.
3. The dialogs are repeating the same `AlertDialog` + `TextButton` cancel/confirm structure. A shared `ConfirmDialog` widget would reduce this duplication.

---

## `active_exercise_view.dart` (195 lines)

The `BlocConsumer` in `_ActiveExerciseScaffold` has a complex `listenWhen` predicate and an `async listener`. This is correct but dense. The listener handles three separate side effects (navigation, weight dialog, snack bar). Consider splitting into a `MultiBlocListener` for clarity.

---

## `forgot_password_view_body.dart` (188 lines)

Deep nesting issue: The `BlocBuilder` → `AuthContainerParentWidget` → `Column` → `BlocSelector` → `AnimatedSwitcher` nesting is 5 levels deep. The duplicated `AnimatedSwitcher` + `ErrorBanner` pattern appears identically in:
- `main_auth_section.dart`
- `create_account_main_section.dart`
- `forgot_password_view_body.dart`

This is a clear extraction opportunity. An `AnimatedErrorBanner` widget that encapsulates the `AnimatedSwitcher` + fade-slide transition + `ErrorBanner` pattern would eliminate ~20 lines of duplication per usage.

---

## Duplicated UI Patterns

### Pattern 1: Animated Error Banner (3 occurrences)
Identical code in `main_auth_section.dart`, `create_account_main_section.dart`, and `forgot_password_view_body.dart`:
```dart
BlocSelector<XCubit, XState, String?>(
  selector: (state) => state is XFailure ? state.message : null,
  builder: (context, errorMessage) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 280),
      transitionBuilder: (child, animation) => FadeTransition(...SlideTransition(...)),
      child: errorMessage != null
          ? Padding(key: ValueKey(errorMessage), child: ErrorBanner(...))
          : const SizedBox.shrink(key: ValueKey('no-error')),
    );
  },
),
```
**Should be extracted to**: `AnimatedErrorBanner<TCubit, TState>` or a simpler non-generic version that accepts `String? errorMessage`.

### Pattern 2: Confirm Dialog (3 occurrences)
`_confirmSignOut`, `_confirmReset`, `_confirmDeleteAccount` all follow:
```dart
showDialog(builder: (ctx) => AlertDialog(
  title: Text(...),
  content: Text(...),
  actions: [TextButton(cancel), TextButton(action, red)]
))
```
**Should be extracted to**: A shared `AppConfirmDialog.show()` static method or a `showConfirmDialog()` function in `core/widgets/`.

### Pattern 3: BlocSelector for Loading State (2 occurrences)
```dart
BlocSelector<XCubit, XState, bool>(
  selector: (state) => state is XLoading,
  builder: (context, isLoading) => CustomButton(isLoading: isLoading, ...),
)
```
Appears in both `main_auth_section.dart` and `create_account_main_section.dart`. Acceptable duplication level.

---

## Business Logic in Widgets

### `profile_view.dart` — Display Name Derivation
`ProfileView._displayNameFor()` performs complex string manipulation (email handle parsing, capitalization, segment joining) to derive a display name. This is business logic that should be in `ProfileCubit` or a utility class, not in a view widget.

### `home_view_body.dart` — Route String Literal
```dart
Navigator.of(context, rootNavigator: true).pushNamed('/activeExercise', ...);
```
A raw string `'/activeExercise'` is used instead of `AppNavigation.activeExercise`. This bypasses the navigation abstraction.

### `weekly_blueprint_section.dart` — Date Calculation
`_dateForWeekday()` and `_currentWeekNumber()` are static utility methods inside a widget class. These belong in a `DateUtils` or similar utility class.

---

## Oversized Cubits Analysis

`ActiveExerciseCubit` at 167 lines is the largest Cubit and is justifiably large — it manages timers, set state, navigation between exercises, validation, and weight updates. It is not over-bloated; it has a single coherent responsibility.

`AuthSessionCubit` at 112 lines orchestrates auth + profile creation + onboarding routing. It could be considered to cross into multiple responsibilities, but the coupling is intentional for session flow management.

---

## Architecture Drift Risks

1. **`LearnView`** demonstrates that under time pressure, the feature-based clean architecture was abandoned entirely. If this pattern continues (hardcode → ship), the codebase will become inconsistent.
2. **Stats cards in `home_view_body.dart`**: The `StatsInfoCard` values `'94%'` and `'2,450'` are hardcoded strings not from state, not localized, and with hardcoded English subtitles. This suggests the home feature is partially incomplete.
3. **`store_service.dart` dead files**: These were not cleaned up, showing a tendency to leave dead code in place.
4. **`AuthException` vs `Exception`**: `FirebaseAuthService` throws `Exception(message)` not `AuthException(message)` — the `AuthException` class defined in `core/errors/` is never actually thrown. Dead type.

---

## Specific Refactoring Recommendations

1. **Extract `AnimatedErrorBanner`** widget to `core/widgets/animated_error_banner.dart`.
2. **Extract `AppConfirmDialog`** to `core/widgets/app_confirm_dialog.dart`.
3. **Refactor `LearnView`**: add `LearnCubit`, move data to a repository stub, add l10n, remove raw colors.
4. **Move `ActiveExerciseArgs`** from `home_view_body.dart` to `workout/presentation/` or a shared types file.
5. **Delete `storage_service.dart` and `firebase_storage_service.dart`**.
6. **Fix memory leak**: Dispose `TextEditingController` in `_showReauthDialog`.
7. **Move `_displayNameFor`** from `ProfileView` to `ProfileCubit`.
8. **Replace raw route string** in `home_view_body.dart` with `AppNavigation.activeExercise`.
9. **Move date utils** from `weekly_blueprint_section.dart` to `core/utils/`.
10. **Make `AppNavigation.routes` unmodifiable**: `Map.unmodifiable(...)`.
