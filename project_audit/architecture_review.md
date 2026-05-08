# Architecture Review — FitFlow

## Overall Architecture Pattern
Feature-based Clean Architecture with Cubit state management. Each feature follows a consistent layered structure: `data/model`, `data/repo`, `domain/repo` (interface), and `presentation/cubit + views`.

---

## Feature Structure Quality

**Score: 8/10**

The feature folder layout is consistent and well-organized:
```
features/<name>/
  data/model/
  data/repo/
  domain/repo/
  presentation/cubit/
  presentation/views/widgets/
```

**Strengths:**
- Every feature with data access has a domain interface (`AuthRepo`, `UserProfileRepo`, `WorkoutRepo`).
- Data models are isolated from presentation — widgets never import `firebase_auth` directly.
- The `core/` layer provides genuinely shared utilities (colors, text styles, validators, widgets, l10n) with no feature coupling.

**Weaknesses:**
- `onboarding/presentation/models/goal_model.dart` creates a "models" folder inside presentation, violating the data/domain split convention used elsewhere.
- The `home` feature has no `data/` or `domain/` layer at all — it directly takes `WorkoutRepo` as a dependency, which is fine but is a slight architectural asymmetry.
- The `learn` feature has no Cubit, no state management, and is entirely a 392-line static mockup inside a single `StatefulWidget` — architecturally incomplete.

---

## Separation of Concerns

**Score: 8.5/10**

- **Views** are genuinely dumb: they read state from Cubits via `BlocBuilder`/`BlocSelector` and call Cubit methods. No direct service calls from widgets.
- **One violation found**: `HomeView` calls `getIt<WorkoutRepo>()` directly inside `build()`. This is an accepted pattern for BlocProvider at the view level per the project's own CLAUDE.md, but it couples the view to the DI container.
- **Another violation**: `ProfileCubit` instantiates `ImagePicker` directly (`final _imagePicker = ImagePicker()`), rather than injecting it. This makes `ProfileCubit` harder to unit test and violates dependency injection principles.
- `AuthSessionCubit` calls `_userProfileRepo` to create and fetch profiles — this is business orchestration logic that arguably belongs in a use case/interactor layer. For a starter template, this is acceptable but worth noting.

---

## Repository Pattern Quality

**Score: 9/10**

- All repositories return `Either<Failure, T>` (via `dartz`), enforcing explicit error handling at every call site.
- Interfaces are in `domain/repo/`, implementations in `data/repo/`.
- `WorkoutRepo` is deliberately synchronous (no `Either`, no `Future`) — a clean, explicit architectural decision documented in CLAUDE.md. This is appropriate for in-memory data.
- `DatabaseService` is a thin abstraction over Firestore — only user CRUD. It's too narrow to be reusable for other collections (future features would need to extend it significantly).
- `UserProfileRepo.updateProfile()` accepts `Map<String, dynamic>` — this is weakly typed. A strongly-typed `UserProfileUpdate` model would be more template-worthy.

---

## Cubit Ownership and Scope

**Score: 8/10**

- `AuthSessionCubit` is app-scoped (created in `FitFlow.build()` via `MultiBlocProvider`) — correct, as auth session is global.
- `LocaleCubit` is registered in `get_it` as a singleton and provided via `BlocProvider.value` — correct approach for a cross-cutting concern.
- Feature Cubits (`SignInCubit`, `SignUpCubit`, `ProfileCubit`, `HomeCubit`, `ActiveExerciseCubit`) are created at the view level — correct.
- `MainCubit` is view-scoped — it just holds an `int` tab index. Its existence as a full Cubit is overkill; a simple `ValueNotifier<int>` or even a `StatefulWidget` int would suffice.

---

## Service Layer Design

**Score: 7.5/10**

- `AuthService` and `DatabaseService` are clean abstract interfaces.
- `CacheHelper` is a well-designed SharedPreferences wrapper with typed methods.
- `LocalImageServiceImpl` is clean and handles one responsibility.

**Weaknesses:**
- `storage_service.dart` and `firebase_storage_service.dart` are dead files with only comments. They need to be deleted.
- `FirebaseAuthService` throws generic `Exception(message)` — losing type information. The calling layer catches `Exception` and re-wraps it. This exception → message → exception chain is messy; the service should throw domain-typed exceptions consistently.
- `CacheHelper` couples to `AuthUser` directly — it imports from a feature (`features/auth/data/model/auth_user.dart`). This means the core service layer has a dependency on a feature model, which is a layering violation.

---

## Navigation Architecture

**Score: 6.5/10**

- Named routes are used consistently via `AppNavigation`.
- Route arguments use typed structs (`ActiveExerciseArgs`) — correct.

**Weaknesses:**
- **Navigation is imperative and global** — `fit_flow.dart` uses a `GlobalKey<NavigatorState>` to navigate from a `BlocListener` inside the `MaterialApp.builder`. This is functional but brittle; it does not scale well when nested navigators are added (e.g., each tab having its own navigator stack).
- `ActiveExerciseArgs` is defined inside `home_view_body.dart` — it belongs in a shared location or inside the workout feature itself, not in the home widget file.
- No deep-link support.
- No route guard pattern — authentication routing is handled via `BlocListener` in `FitFlow` which tightly couples navigation logic to the root widget.
- `AppNavigation.routes` is a mutable `static Map` — should be `static const` or unmodifiable.
- Missing routes for `profile_settings`, `edit_profile`, etc. — suggests the pattern will break down as the app grows.

---

## Dependency Injection Quality

**Score: 8/10**

- `get_it` with `registerLazySingleton` throughout — correct.
- Guards (`if (!getIt.isRegistered<T>())`) protect against double-registration — useful for testing but signals the DI setup may be called multiple times somewhere.
- `LocaleCubit` is registered in `get_it` as a singleton, but Cubits are generally not DI-registered in clean architecture — this is a pragmatic choice to share locale state across the app without a root provider. Acceptable but unusual.
- The service locator setup is in a single function `setupServiceLocator()` in one file — easy to read and modify.

---

## Firebase Integration

**Score: 7/10**

- `FirebaseAuthService` is well-implemented: handles re-authentication flows, Google sign-in cancellation, session expiry cleanup, and language code sync.
- `FirestoreService` is extremely thin — only 4 CRUD operations on the `users` collection. There is no collection abstraction for future features.
- No Firestore offline persistence is configured (`FirebaseFirestore.instance.settings` not set).
- No Firestore security rules file found in the project — this is a production-readiness gap.
- No error handling distinction between network errors and Firestore permission errors.

---

## Strengths (Specific)

1. **`AuthSessionCubit` + sealed states**: The 7-state sealed class with `AuthSessionNeedsReauth`, `AuthSessionSigningOut` (preventing navigation loops) is genuinely thoughtful design.
2. **`FirebaseAuthService._reauthAndDelete()`**: Handles the Google and email/password re-auth flows correctly with provider detection — this is non-trivial code done right.
3. **`ActiveExerciseCubit` timer management**: Dual-timer (exercise + rest), `close()` override, sentinel pattern in `copyWith` — clean, production-grade Cubit design.
4. **`CacheHelper`**: Well-typed SharedPreferences wrapper with clear constants and no magic strings scattered across the codebase.
5. **Domain interfaces for all data sources**: `AuthRepo`, `UserProfileRepo`, `WorkoutRepo` are all abstract — the app is testable at the repository boundary.

---

## Weaknesses (Specific)

1. **`LearnView` (392 lines)**: Entire feature is a single stateful widget with hardcoded static data, no Cubit, no l10n (hardcoded "Learn" string), and raw `Color` literals (`Color(0xFF1A3FAB)`). Architecturally abandoned.
2. **`CacheHelper` imports `AuthUser`**: Core service layer depends on a feature model — layering violation.
3. **`ProfileCubit` owns `ImagePicker`**: Not injected, not testable in isolation.
4. **`AppNavigation.routes` is mutable**: `static Map` not `const` — can be mutated at runtime.
5. **No test files found**: Despite `mocktail` being imported as a production dependency, no test files were found in `test/`.

---

## Scalability Concerns

- `DatabaseService` only has user CRUD — adding workouts, progress logs, social features requires redesigning or extending this interface.
- Single-collection Firestore model (`users/`) will need subcollections or separate collections as data grows.
- Named route navigation breaks down with multiple nested navigators (required for tab-based apps with their own stacks).
- `AppLocalizations` is hand-maintained — with growth, it becomes a file that needs to be edited every time a string is added. No codegen means no compile-time string key safety.

---

## Template Reuse Quality

The architecture is well above average for a Flutter template. The clean separation, consistent patterns, and explicit error handling provide a solid foundation. The main gaps for template reuse are the dead files, the `mocktail` dependency placement, the incomplete `learn` feature, and the lack of tests.
