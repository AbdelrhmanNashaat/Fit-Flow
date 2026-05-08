# State Management Review — FitFlow

## Overview
The project uses `flutter_bloc` with Cubits exclusively. No traditional Bloc events are present — appropriate for this complexity level. There are 9 Cubits total across 7 features.

---

## Cubit Inventory

### 1. `AuthSessionCubit`
- **File**: `lib/features/auth/presentation/cubit/auth_session_cubit.dart` (112 lines)
- **Responsibility**: Global session management — check auth status, route to home/onboarding, sign out, delete account, reset onboarding.
- **State class**: `sealed class AuthSessionState` — 7 concrete states
- **States**: `AuthSessionInitial`, `AuthSessionChecking`, `AuthSessionAuthenticated`, `AuthSessionNeedsOnboarding`, `AuthSessionNeedsReauth`, `AuthSessionSigningOut`, `AuthSessionUnauthenticated`, `AuthSessionFailure`
- **Sealed**: Yes — full Dart 3 sealed class
- **copyWith**: Not applicable (no data-carrying state uses copyWith; states carry different payload types)
- **Loading/error**: Handled via `AuthSessionChecking` and `AuthSessionFailure` states
- **Assessment**: **Excellent**. The `AuthSessionSigningOut` sibling state (not a subclass of `Authenticated`) to prevent navigation race conditions is a sophisticated, production-level design decision. The `_currentUser` getter using pattern matching across multiple states is clean. Well-structured.

---

### 2. `SignInCubit`
- **File**: `lib/features/auth/presentation/cubit/sign_in_cubit.dart` (29 lines)
- **Responsibility**: Email/password and Google sign-in flow.
- **State class**: `sealed class SignInState`
- **States**: `SignInInitial`, `SignInLoading` (with `isGoogle` flag), `SignInSuccess`, `SignInFailure`
- **Sealed**: Yes
- **copyWith**: Not needed — states carry distinct payloads
- **Loading/error**: Correct. `SignInLoading.isGoogle` differentiates which button shows spinner.
- **Assessment**: **Good**. The `isGoogle` field on `SignInLoading` is a pragmatic UI detail correctly placed in the state.

---

### 3. `SignUpCubit`
- **File**: `lib/features/auth/presentation/cubit/sign_up_cubit.dart` (28 lines)
- **Responsibility**: Email/password and Google sign-up.
- **State class**: `sealed class SignUpState` — **not using `const` constructors on `SignUpInitial`, `SignUpLoading`, `SignUpSuccess`, `SignUpFailure`**
- **Sealed**: Yes
- **Assessment**: **Good but inconsistent with `SignInState`**. `SignInLoading` uses `const` constructors; `SignUpLoading` does not. `SignInFailure` uses a positional argument with `SignInFailure(this.message)` — no `const`. These minor inconsistencies signal copy-paste without standardization. Also: the `signUpWithGoogle` method calls `_authRepo.signInWithGoogle()` — naming mismatch (sign in vs sign up for Google is the same flow, but naming is misleading in the Cubit method).

---

### 4. `ResetPasswordCubit`
- **File**: `lib/features/auth/presentation/cubit/reset_password_cubit.dart` (20 lines)
- **Responsibility**: Password reset email flow.
- **State class**: `sealed class ResetPasswordState` — all states use `const` constructors
- **States**: `ResetPasswordInitial`, `ResetPasswordLoading`, `ResetPasswordSuccess`, `ResetPasswordFailure`
- **Assessment**: **Good**. Clean and minimal.

---

### 5. `OnboardingCubit`
- **File**: `lib/features/onboarding/presentation/cubit/onboarding_cubit.dart` (37 lines)
- **Responsibility**: Goal selection, availability selection, and completing onboarding.
- **State class**: `OnboardingState` — a single class with `copyWith` and `OnboardingStatus` enum
- **Sealed**: **No** — uses an enum-based status pattern instead of sealed states.
- **Assessment**: **Mid-level**. The `OnboardingState` class is not sealed — it uses an `OnboardingStatus` enum (`initial`, `loading`, `success`, `failure`) as a discriminator. This is a common Flutter pattern but inferior to sealed states for a template because:
  1. Exhaustive matching in `switch` is not enforced at compile time.
  2. Error state carries `errorMessage` but loading/success do not — the single state class carries all fields regardless of which are relevant to the current status.
  The inconsistency with other Cubits in the same project is notable.

---

### 6. `LocaleCubit`
- **File**: `lib/features/locale/cubit/locale_cubit.dart` (19 lines)
- **Responsibility**: Language selection persistence.
- **State type**: `Locale` (not a custom state class)
- **Assessment**: **Excellent**. Using `Locale` directly as the state is the correct approach — no unnecessary wrapper class. The `_initialLocale` static helper for constructor initialization is clean.

---

### 7. `HomeCubit`
- **File**: `lib/features/home/presentation/cubit/home_cubit.dart` (58 lines)
- **Responsibility**: Load today's workout and weekly schedule.
- **State class**: `sealed class HomeState`
- **States**: `HomeInitial`, `HomeLoading`, `HomeLoaded`, `HomeError`
- **Sealed**: Yes
- **copyWith**: Not present on `HomeLoaded` — the loaded state has no mutation after load, so this is acceptable.
- **Assessment**: **Good**. The `_buildWeekSchedule` helper and `_greeting()` are pure functions inside the Cubit — appropriate. `HomeLoaded.isRestDay` computed getter is clean.

---

### 8. `ProfileCubit`
- **File**: `lib/features/user_profile/presentation/cubit/profile_cubit.dart` (80 lines)
- **Responsibility**: Load profile + app version in parallel, pick and save profile image.
- **State class**: `sealed class ProfileState`
- **States**: `ProfileInitial`, `ProfileLoading`, `ProfileLoaded`, `ProfileError`
- **Sealed**: Yes
- **copyWith**: Present on `ProfileLoaded` — used for image upload progress state.
- **Assessment**: **Good**. The parallel `Future.wait` pattern via the `_WaitTwo` extension record is creative and correct. However, the extension `_WaitTwo` defined at the bottom of the Cubit file is unconventional — it should either be in `core/utils/` or removed in favor of an explicit `Future.wait([...])` call.

---

### 9. `ActiveExerciseCubit`
- **File**: `lib/features/workout/presentation/cubit/active_exercise_cubit.dart` (167 lines)
- **Responsibility**: Manage active workout session — timer, sets, navigation between exercises, rest timer, validation.
- **State class**: `sealed class ActiveExerciseState` — 2 states
- **States**: `ActiveExerciseReady` (rich, many fields), `ActiveExerciseFinished`
- **Sealed**: Yes
- **copyWith**: Present with **sentinel pattern** for nullable fields — sophisticated and correct.
- **Timer cleanup**: `close()` override cancels both timers — correct.
- **Assessment**: **Excellent**. The sentinel object pattern for nullable `copyWith` parameters (`validationError`, `restTimerSeconds`) solves a real Dart problem elegantly. Timer lifecycle management is handled correctly. The Cubit is appropriately sized for its responsibility.

---

### 10. `MainCubit`
- **File**: `lib/features/main/presentation/cubit/main_cubit.dart` (7 lines)
- **Responsibility**: Track which bottom nav tab is selected.
- **State type**: `int`
- **Assessment**: **Over-engineered**. A full Cubit for a single integer is unnecessary. A `ValueNotifier<int>` or a `StatefulWidget` int would accomplish the same with less ceremony. There's no persistence, no async work, no complex state transitions.

---

## Overall Naming Consistency

| Aspect | Status |
|---|---|
| State classes named `<Feature>State` | ✅ Consistent |
| Sealed classes for all states | ✅ Mostly (OnboardingState is exception) |
| `const` constructors on state classes | ⚠️ Inconsistent (SignUpState lacks them) |
| Error states carry `message: String` | ✅ Consistent |
| Loading states have no payload | ✅ Consistent |
| `copyWith` on loaded states | ✅ Present where needed |
| Cubit methods match user actions | ✅ Consistent |

---

## State Explosion Risk

**Low to Medium**. The most complex state is `AuthSessionState` with 7 variants — appropriate for the auth lifecycle. No Cubit shows signs of uncontrolled state proliferation.

---

## Rebuild Risks

- `BlocSelector` is used in `main_auth_section.dart` and `create_account_main_section.dart` to narrow rebuilds to specific state fields (e.g., just the loading boolean, just the error message). This is correct usage.
- `context.watch<AuthSessionCubit>()` in `HomeView.build()` causes `HomeView` to rebuild on every `AuthSessionState` change. Since `HomeView` only reads `userName` from the state, a `BlocSelector` should be used instead.
- The timer in `ActiveExerciseCubit` emits every second — every `BlocBuilder` listening to `ActiveExerciseCubit` rebuilds every second. The `_RestTimerButton` widget listens to the full state and will rebuild every second during both the exercise timer and rest timer. This is a performance concern in the active exercise screen.

---

## Recommendations

1. **Convert `OnboardingState` to sealed classes** — align with the rest of the codebase.
2. **Add `const` constructors to `SignUpState` subclasses** — consistency.
3. **Replace `MainCubit` with `ValueNotifier<int>` or `StatefulWidget`** — reduces unnecessary ceremony.
4. **Add `BlocSelector` in `HomeView`** to avoid rebuilding on every `AuthSessionState` change.
5. **Split `ActiveExerciseCubit` rebuild scope**: The elapsed timer and rest timer both cause every listener to rebuild every second. Consider using separate `BlocBuilder` with `buildWhen` for the timer display, isolating rebuilds.
6. **Move `_WaitTwo` extension** from `profile_cubit.dart` to a shared utility file.
7. **Rename `signUpWithGoogle` in `SignUpCubit`** to avoid confusion — Google OAuth is the same sign-in/sign-up flow.
