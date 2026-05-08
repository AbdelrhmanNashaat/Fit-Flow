# Performance Review — FitFlow

## Summary
Performance is generally good for a pre-production app. The most significant concern is the timer-driven rebuild cycle in the active exercise screen and the 1-second emission cadence from `ActiveExerciseCubit`. No `ListView.builder` issues were found for current data volumes, but hardcoded static lists could be a concern at scale.

---

## `const` Constructor Coverage

### Overall: Good — Most widgets use `const` constructors correctly.

**Correct const usage found in:**
- All state classes in Cubits
- `SizedBox`, `EdgeInsets`, `Icon`, `Text` where values are compile-time constants
- Core widgets (`CustomButton`, `CustomTextField`) accept `const` construction at call sites
- `LocalWorkoutRepo` is `const LocalWorkoutRepo()`
- Exercise data in `sample_workout_data.dart` uses `const` throughout

**Missing `const` opportunities:**
- `_DayChip` in `weekly_blueprint_section.dart`: The `build` method builds `Row` children without `const` where possible
- `MainCubit()` is instantiated without `const` — acceptable since `super(0)` is not compile-time
- Several `Container` widgets with `BoxDecoration` could use `const` if their color values are `AppColors.*` constants (already `const`)
- `_FeaturedCard` and `_VideoCard` in `learn_view.dart` take a `_VideoItem` — the items themselves are `const` but the widgets are not

---

## BlocBuilder Rebuild Scopes

### Issues Found

**1. `HomeView` — Unnecessary full-state watch**
```dart
// lib/features/home/presentation/views/home_view.dart
final authState = context.watch<AuthSessionCubit>().state;
final userName = switch (authState) { ... };
```
`context.watch<AuthSessionCubit>()` subscribes `HomeView` to **every** `AuthSessionState` change. Auth state changes frequently (checking → authenticated → etc.). Should use `BlocSelector`:
```dart
final userName = context.select<AuthSessionCubit, String>(
  (cubit) => switch (cubit.state) {
    AuthSessionAuthenticated(:final user) => user.name,
    _ => '',
  },
);
```

**2. Active Exercise Screen — Per-second full rebuild**
`ActiveExerciseCubit` emits every second for both the elapsed timer and the rest timer:
```dart
// active_exercise_cubit.dart:168
_exerciseTimer = Timer.periodic(const Duration(seconds: 1), (_) {
  emit(s.copyWith(elapsedSeconds: s.elapsedSeconds + 1));
});
```
The `_ActiveExerciseBody` is wrapped in `BlocConsumer` which rebuilds the entire exercise screen body every second. This includes:
- The `FormCueCard`
- The exercise name `Text`
- The `ExerciseMediaSection`
- Every `WorkoutSetRow`
- The `AddSetButton`

None of these need to rebuild every second — only the elapsed time display and the rest timer button need per-second updates. **Recommendation**: Add `buildWhen` to `_ActiveExerciseScaffold`'s builder, or decompose the screen into separate widgets with isolated `BlocBuilder` scopes.

**3. `_RestTimerButton` — Unnecessary rebuild source**
```dart
class _RestTimerButton extends StatelessWidget {
  const _RestTimerButton({required this.state, required this.cubit});
  final ActiveExerciseReady state;
```
`_RestTimerButton` receives the full `ActiveExerciseReady` state as a prop — it rebuilds every time any field in state changes (i.e., every second). It only needs `restTimerSeconds` and `isRunning`. It should read from the Cubit directly with `BlocSelector`.

---

## List Rendering

**No performance issues for current data volume:**

- `home_view_body.dart`: Uses `Column` with `for (int i = 0; i < exercises.length; i++)` for today's exercises. Exercise count is always 4–6 items — `Column` is appropriate. Not a `ListView.builder` issue.
- `active_exercise_view.dart`: `ListView` with `...state.sets.asMap().entries.map(...)` — typically 3–6 items. Fine.
- `learn_view.dart`: `Column(children: _filtered.map((v) => _VideoCard(...)).toList())` — 7 items. This is inside a `ListView`, so fine for now. If this list grows to 50+ items, a `ListView.builder` inside the outer `ListView` will be needed (or a `SliverList`).
- `weekly_blueprint_section.dart`: `Row` with 7 children — always exactly 7, no performance concern.

---

## Image Loading

- **Profile images**: Use `FileImage(File(path))` — loaded directly from disk. No caching library is used. For a single profile image this is fine, but `FileImage` does not cache in memory; each rebuild reads from disk if not cached by Flutter's `ImageCache`.
- **Exercise images**: `exercise.imageAsset` is always null in current sample data — the `Image.asset` fallback never runs. When real images are added, `Image.asset` uses Flutter's built-in `AssetBundleImageProvider` which does cache — this is fine.
- **Auth/logo images**: `flutter_svg` is used for SVGs — `SvgPicture.asset` caches the parsed SVG tree.
- **No `CachedNetworkImage`**: Not needed currently since there are no network images.

---

## IndexedStack Usage

`PersistentTabView` in `main_view.dart` with `stateManagement: true` uses `IndexedStack` internally to preserve tab state. This means all 3 tab screens (`HomeView`, `LearnView`, `ProfileView`) are built and kept in memory simultaneously. This is the correct approach for tab persistence but means:

- `HomeCubit` is active as long as `MainView` is alive — the elapsed timer concern in `ActiveExerciseCubit` does not apply here.
- `ProfileCubit.loadProfile()` is called when `MainView` first builds — if the auth state changes, `ProfileView` re-creates its `BlocProvider` and reloads. This is fine.

---

## Firebase Reads

Current Firebase reads are triggered:
1. `AuthSessionCubit.checkAuthStatus()` → `AuthService.getCurrentUser()` → `user.reload()` (network call) + `UserProfileRepo.getProfile()` → Firestore read.
2. Every time the user navigates to the Profile tab while `ProfileCubit` is freshly created → `UserProfileRepo.getProfile()`.

**Issues:**
- No caching of Firestore data — every app launch triggers a Firestore read for the user profile.
- No `FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true)` — offline persistence is disabled by default in newer versions of the SDK (it was enabled by default in older versions). This means cold launches without network will fail to load the profile.
- No pagination — not needed for current single-user data model.

---

## `initState` Heavy Work

- `_MainScaffoldState.initState()` creates a `PersistentTabController` — lightweight.
- `FitFlow.initState()` removes the splash screen with a post-frame callback — correct.
- `AuthSessionCubit.checkAuthStatus()` is triggered in `FitFlow.build()` via `..checkAuthStatus()` in `BlocProvider.create`. This is a network call triggered from `build()` indirectly — acceptable pattern for auth session restoration.

---

## Recommendations

1. **Fix `HomeView` context.watch** → use `context.select` — reduces rebuilds on auth state changes.
2. **Add `buildWhen` to `ActiveExerciseBody`** or split the screen into timer and non-timer widget trees — stops per-second full-screen rebuilds.
3. **Enable Firestore offline persistence**: Add `FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true)` in `AppBootstrap.init()`.
4. **Cache profile data** in `CacheHelper` to allow offline profile display without a Firestore round-trip.
5. **Convert `_filtered.map(...).toList()` in `LearnView`** to `ListView.builder` when real data is added.
6. **Profile image**: Consider wrapping `FileImage` in a `RepaintBoundary` to isolate avatar rebuilds.
