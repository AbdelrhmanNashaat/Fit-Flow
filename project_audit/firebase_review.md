# Firebase Review — FitFlow

## Firebase Services Used

| Service | Package | Status |
|---|---|---|
| Firebase Core | `firebase_core: ^4.4.0` | Active |
| Firebase Auth | `firebase_auth: ^6.1.4` | Active |
| Cloud Firestore | `cloud_firestore: ^6.3.0` | Active |
| Firebase Storage | Not included | Not used |
| Firebase Messaging | Not included | Not implemented |
| Firebase Analytics | Not included | Not implemented |
| Cloud Functions | Not included | Not used |

---

## Firebase Initialization

`AppBootstrap.init()` calls `Firebase.initializeApp()` with no `FirebaseOptions` specified. This relies on:
- Android: `google-services.json`
- iOS: `GoogleService-Info.plist`

The initialization is clean and sequential: Firebase → SharedPreferences → DI setup. No issues found.

**Missing**: No `FirebaseFirestore.instance.settings` configuration for offline persistence. Default behavior in SDK v6+ is persistence **disabled** by default on some platforms. Should explicitly enable:
```dart
FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);
```

---

## FirebaseAuth Flows

### Sign In / Sign Up
`FirebaseAuthService.signIn()` and `signUp()` wrap `FirebaseAuth` calls with `try/catch` on `FirebaseAuthException`, mapping to `FirebaseErrors.fromCode()`. Clean and correct.

### Google Sign-In
`signInWithGoogle()` correctly:
1. Checks for null `googleUser` (user cancelled)
2. Checks for null `idToken` (misconfigured server client ID)
3. Creates `GoogleAuthProvider.credential()` with both tokens
4. Calls `signInWithCredential()`

This is a well-implemented Google sign-in flow.

### Re-authentication for Account Deletion
`_reauthAndDelete()` correctly:
1. Detects provider from `user.providerData.first.providerId`
2. For Google: re-runs Google sign-in flow, gets fresh credential
3. For email/password: throws `ReauthRequiredException` (typed exception) when no password is provided, which bubbles up through the repo as `ReauthRequiredFailure` and manifests as `AuthSessionNeedsReauth` in the UI

This is a production-quality re-auth implementation.

### Session Restoration
`getCurrentUser()`:
1. Calls `_auth.currentUser`
2. Calls `currentUser.reload()` to validate the token against Firebase servers
3. Handles stale session codes with auto sign-out

The `.reload()` call is a network request on every app launch. This is correct for security (ensures the token is still valid) but adds latency to cold starts.

### Language Code Sync
`_ensureLanguageCode()` syncs Firebase Auth's language to the device locale before every operation — this ensures password reset emails are sent in the user's language. Thoughtful detail.

---

## Firestore Structure

### Collection: `users/{uid}`

Based on `UserProfile.toJson()`:
```json
{
  "uid": "string",
  "email": "string",
  "name": "string?",
  "myGoal": "string? (enum: buildMuscle | getStrong | generalFitness)",
  "weeklyAvailability": "int?",
  "isOnboardingCompleted": "boolean",
  "createdAt": "Timestamp"
}
```

**Issues:**
- `uid` is stored as a field AND is the document ID — redundant. Consider removing the field or not storing it twice.
- `myGoal` stores enum names as raw strings. No type safety — a typo would silently store an invalid value. Consider storing a validated enum key.
- No schema versioning — if fields are renamed or added in the future, old documents will fail to parse without migration logic.
- `createdAt` uses `Timestamp` — good.

### No Other Collections
The Firestore structure only has the `users` collection. Workout plans, progress logs, and session history are in-memory only. This is documented as intentional for the current phase.

---

## Security Rule Concerns

**No `firestore.rules` file was found in the project.** This is a critical production gap.

Without explicit security rules, the Firestore database is likely using the default rules from Firebase console setup. Default rules (from Firebase's quickstart templates) are often:
```
allow read, write: if false;  // or if request.auth != null;
```

For template use, the project should include a `firestore.rules` file with at minimum:
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

**No `firestore.indexes.json` file found either.** No composite indexes are needed currently, but this should be initialized.

---

## DatabaseService Quality

`DatabaseService` abstraction is functional but limited:
- Only 4 operations: `createUser`, `getUser`, `updateUser`, `deleteUser`
- Operates on raw `Map<String, dynamic>` — no type safety at the service boundary
- Single `users` collection hard-coded in `FirestoreService` — not reusable for other collections
- `updateUser` uses Firestore `update()` (not `set()`) — correct for partial updates
- No `transaction` support — concurrent updates could cause race conditions on `isOnboardingCompleted` flag

For a template, the `DatabaseService` interface is too narrow. A more reusable approach would be:
```dart
abstract class DatabaseService {
  Future<void> setDocument(String collection, String id, Map<String, dynamic> data);
  Future<Map<String, dynamic>?> getDocument(String collection, String id);
  Future<void> updateDocument(String collection, String id, Map<String, dynamic> data);
  Future<void> deleteDocument(String collection, String id);
}
```

---

## Error Handling in Firebase Calls

`FirestoreService` does **not** catch errors — if Firestore throws, the exception propagates to `UserProfileRepoImpl` which catches it as `catch (e)` and wraps it in `Left(Failure(e.toString()))`. This loses error type information (e.g., permission denied vs network error).

`FirebaseAuthService` maps `FirebaseAuthException` codes to user-friendly messages via `FirebaseErrors.fromCode()`. The default case returns `'An unknown error occurred.'` — better than exposing raw Firebase error codes but not the most informative.

---

## Caching Strategy

Current caching:
- **Auth user**: Serialized to `SharedPreferences` via `CacheHelper.cacheUser()` — JSON string.
- **Login state**: `is_logged_in` boolean key in `SharedPreferences`.
- **Profile image path**: String path in `SharedPreferences`.
- **Locale**: String in `SharedPreferences`.
- **No profile data caching**: Every tab navigation to Profile → Firestore read.

There is no in-memory or persistent cache for `UserProfile`. This means:
1. Every profile tab visit triggers a Firestore read.
2. Offline mode shows an error instead of cached data.

---

## Recommendations

1. **Add `firestore.rules` to the project** — critical security gap.
2. **Enable Firestore offline persistence** in `AppBootstrap.init()`.
3. **Cache `UserProfile`** in `CacheHelper` (JSON-serialized) to support offline display.
4. **Broaden `DatabaseService` interface** for multi-collection support.
5. **Remove `uid` from Firestore document fields** — it's redundant with the document ID.
6. **Add `firestore.indexes.json`** — even if empty, establishes the convention for future indexes.
7. **Add error type distinction** in `UserProfileRepoImpl` catch blocks — distinguish `FirebaseException` (permission denied) from network errors.
8. **Consider schema version field** in user documents for future migrations.
