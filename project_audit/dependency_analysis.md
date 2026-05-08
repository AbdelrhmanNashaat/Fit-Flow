# Dependency Analysis — FitFlow

## Environment
- **Dart SDK**: `^3.11.0` (bleeding edge, requires latest stable Flutter)
- **App version**: `1.0.0+1`

---

## Production Dependencies

| Package | Version | Purpose | Weight |
|---|---|---|---|
| `cloud_firestore` | ^6.3.0 | Firestore database | Heavy |
| `firebase_auth` | ^6.1.4 | Firebase Auth (email, Google) | Heavy |
| `firebase_core` | ^4.4.0 | Firebase initialization | Heavy |
| `flutter_bloc` | ^9.1.1 | State management (Cubit) | Medium |
| `get_it` | ^9.2.1 | Service locator / DI | Minimal |
| `dartz` | ^0.10.1 | Functional Either/Option types | Small |
| `google_sign_in` | ^6.2.1 | Google OAuth sign-in | Medium |
| `shared_preferences` | ^2.5.3 | Key-value local storage | Minimal |
| `path_provider` | ^2.1.5 | App documents directory | Minimal |
| `image_picker` | ^1.1.2 | Gallery/camera image selection | Medium |
| `package_info_plus` | ^8.3.0 | App version string | Minimal |
| `flutter_svg` | ^2.2.4 | SVG rendering | Small |
| `flutter_animate` | ^4.5.2 | Animation utilities | Small |
| `shimmer` | ^3.0.0 | Loading skeleton effect | Small |
| `url_launcher` | ^6.3.1 | Open URLs (legal links) | Small |
| `persistent_bottom_nav_bar` | ^6.2.1 | Persistent tab navigation bar | Medium |
| `intl` | ^0.20.2 | Internationalization utilities | Small |
| `flutter_native_splash` | ^2.4.7 | Native splash screen config | Dev |
| `flutter_launcher_icons` | ^0.14.4 | App icon generator | Dev |
| `cupertino_icons` | ^1.0.8 | iOS-style icons | Small |
| `mocktail` | ^1.0.4 | **MISPLACED**: test mock library in production deps | Minimal |

---

## Firebase Packages Analysis

Three Firebase packages are used:
- `firebase_core` — required baseline
- `firebase_auth` — email/password, Google sign-in, account deletion with re-auth
- `cloud_firestore` — user profile CRUD

**Missing but potentially needed:**
- `firebase_storage` is NOT used (images are stored locally, not in Firebase Storage — a deliberate choice documented in `local_image_service_impl.dart`)
- No FCM (`firebase_messaging`) — push notifications not implemented
- No Analytics (`firebase_analytics`) — no user analytics

---

## Heavy Package Analysis

The following packages contribute significantly to APK/IPA size:

1. **Firebase suite** (`firebase_core` + `firebase_auth` + `cloud_firestore`): Combined ~3–5 MB native footprint. Unavoidable given the feature set.
2. **`google_sign_in`**: ~1.5 MB native. Requires Google Play Services on Android.
3. **`image_picker`**: ~0.5 MB. Requires camera/gallery permissions.
4. **`persistent_bottom_nav_bar`**: Medium-weight navigation package. Could be replaced with a custom navigation bar to reduce dependency footprint.
5. **`dartz`**: ~300 KB. Adds functional programming primitives. Relatively small but adds to code complexity for contributors unfamiliar with functional Dart.
6. **`flutter_svg`**: ~500 KB. Used for logo and auth SVG assets.

---

## Issues and Anomalies

### Critical Issue: `mocktail` in Production Dependencies
`mocktail: ^1.0.4` is listed under **`dependencies`**, not `dev_dependencies`. This is a test-only mocking library that should never be in the production build. It will be included in release builds unnecessarily.

**Fix:** Move to `dev_dependencies`:
```yaml
dev_dependencies:
  flutter_lints: ^6.0.0
  flutter_test:
    sdk: flutter
  mocktail: ^1.0.4
```

### Dead Files: `storage_service.dart` and `firebase_storage_service.dart`
Both files contain only a comment saying they were replaced. They should be deleted entirely.

### `intl` Not Used Directly
`intl` is listed as a dependency but `AppLocalizations` is hand-rolled and does not use `intl` for message formatting. It may only be transitively required by `flutter_localizations`. This is acceptable but worth noting — if `flutter_localizations` from the SDK is the actual consumer, `intl` could potentially be removed from explicit dependencies.

### Google Server Client ID Hard-Coded in Source
`app_config.dart` contains the actual Google Server Client ID string directly in source code (same ID across all flavors). This is a security concern for open-source or template use. Should use environment variables or a `.env` file excluded from version control.

### Same Client ID for All Flavors
`development`, `staging`, and `production` all use the **same** `googleServerClientId`. True flavor separation requires different Firebase projects and different client IDs.

---

## Redundant/Duplicated Functionality

- `flutter_animate` is imported but its usage in the codebase is very limited or absent in the main views reviewed. The `AnimatedSwitcher` and `AnimatedContainer` usages are Flutter built-ins. Verify actual usage of `flutter_animate` before keeping it.

---

## Version Concerns

- `sdk: ^3.11.0` — very recent, which means older Flutter toolchains will fail to build this project. Teams on LTS Flutter versions will need to upgrade.
- All Firebase packages are at major version 4–6, which are the current 2024–2025 releases. No stale versions detected.
- `persistent_bottom_nav_bar: ^6.2.1` — this package has had API-breaking changes between major versions. Pinning to `^6` is correct.

---

## Recommendations

1. **Move `mocktail` to `dev_dependencies` immediately** — this is a bug.
2. **Delete `storage_service.dart` and `firebase_storage_service.dart`** — dead code.
3. **Externalize Google Client ID** — use `--dart-define` or a secrets file excluded from git.
4. **Verify `flutter_animate` usage** — if unused, remove it.
5. **Consider `flutter_hooks`** as an alternative to `StatefulWidget` for form state management in auth screens — would reduce boilerplate significantly.
6. **Consider removing `dartz`** in a future refactor — Dart 3 records and pattern matching can replace `Either<Failure, T>` with a custom sealed class at no additional cost, removing an external dependency.
