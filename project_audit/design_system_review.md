# Design System Review — FitFlow

## Overview
FitFlow uses a manual, static design token approach: `AppColors` and `AppTextStyles` are classes with `static const` fields. There is no `ThemeData` integration beyond a minimal `primaryColor` + `scaffoldBackgroundColor` setup.

---

## Color System (`AppColors`)

**Score: 8/10**

### Strengths
- Semantic naming is present: `backgroundScaffold`, `backgroundAppBar`, `backgroundCard`, `textPrimary`, `textSecondary`, `textTertiary`, `borderColor`, `primaryColor`, `success`, `warning`.
- Well-organized with visual comment separators (brand, backgrounds, text, borders, neutrals, semantic).
- 37 named colors — comprehensive coverage for the current feature set.

### Weaknesses and Inconsistencies

**Naming duplication / unclear distinction:**
- `backgroundButton = Color(0xFFF3F3F3)` and `fillColor = Color(0xFFF3F3F3)` — **identical values, different names**. This is confusing. One should be removed.
- `backgroundSecondary = Color(0xFFF1F5F9)` and `secondaryColor = Color(0xFFF1F5F9)` — **identical values, two names**. Same problem.
- `borderColor = Color(0xFFC3C6D7)` and `borderButton = Color(0xFFC3C6D7)` — **identical values**. `borderButton` appears to be unused. Should be consolidated.

**Raw color literals still used:**
- `error_banner.dart`: `Color(0xFFFEE2E2)`, `Color(0xFFFCA5A5)`, `Color(0xFFDC2626)` — error colors not in `AppColors`.
- `forgot_password_view_body.dart` (`_SuccessCard`): `Color(0xFFDCFCE7)`, `Color(0xFF86EFAC)`, `Color(0xFF16A34A)`, `Color(0xFF15803D)` — success card colors not in `AppColors`.
- `learn_view.dart`: Multiple raw colors (`Color(0xFF1A3FAB)`, `Color(0xFF8B5CF6)`, `Color(0xFFEF4444)`, etc.) — these are arbitrary video card colors but still represent raw literal usage.
- `active_workout_card.dart`: `Color(0xFF1A3FAB)` used in gradient — not in `AppColors`.
- `profile_header_card.dart`: `Colors.black26`, `Colors.white` — uses Flutter's built-in `Colors.*` instead of `AppColors`.

**Missing semantic colors:**
- No `error` or `errorLight` color — only `success` and `warning` are defined. `ErrorBanner` uses its own hardcoded red values.
- No `info` or `infoLight` color.

---

## Typography System (`AppTextStyles`)

**Score: 6/10**

### Defined Styles (15 total)

| Name | Size | Weight | Color | Notes |
|---|---|---|---|---|
| `bold48` | 48 | Bold | white | Auth header (very specific) |
| `bold14` | 14 | Bold | textPrimary | Common |
| `bold16` | 16 | Bold | black | Common |
| `bold18` | 18 | Bold | black | App bar titles |
| `bold20` | 20 | Bold | primaryColor | Unusual color baked in |
| `bold26` | 26 | Bold | primaryColor | Unusual color + letterSpacing |
| `extraBold26` | 26 | ExtraBold | black | Common |
| `extraBold30` | 30 | ExtraBold | black | Profile avatar text |
| `semiBold12` | 12 | SemiBold | hintTextColor | Unusual color baked in |
| `light14` | 14 | Light | white | letterSpacing: 2.8 baked in |
| `medium14` | 14 | Medium | black | Common |
| `regular14` | 14 | Regular | textSecondary | Most common |
| `regular12` | 12 | Regular | textSecondary | Common |
| `regular16` | 16 | Regular | textPrimary | Common |
| `regular17` | 17 | Regular | black | Unusual size |
| `medium12` | 12 | Medium | black | Common |

### Critical Problems

1. **Colors baked into text styles**: `bold48` has `color: AppColors.whiteColor`, `bold26` has `color: AppColors.primaryColor`, `semiBold12` has `color: AppColors.hintTextColor`. Text styles should define size, weight, and font family only — color should be specified at the usage site or via `copyWith(color: ...)`. This is a fundamental design token mistake. The existing code is already calling `.copyWith(color: ...)` constantly on every style that has the wrong color baked in.

2. **No semantic naming**: Styles are named by their visual properties (`bold16`, `regular14`) not by their semantic role (`headlineLarge`, `bodyMedium`, `labelSmall`). This leads to developers picking styles by size rather than role, creating visual inconsistency.

3. **`regular17` is an unusual size**: 17px is not a standard typographic scale size. It suggests a one-off design decision that leaked into the style system.

4. **`light14` has `letterSpacing: 2.8` baked in**: This makes the style highly context-specific (used for spaced-out tracking labels) but it's named `light14` which implies general use.

5. **`bold26` has `letterSpacing: 2.8` baked in**: Same issue — contextual property in a global style name.

6. **Missing sizes**: No `18` regular, no `20` regular, no `24` bold — these gaps cause developers to use `copyWith(fontSize: X)` frequently.

---

## Spacing System

**Score: 4/10 — Weakest area of the design system**

There is **no spacing token system**. All spacing is hardcoded with `const SizedBox(height: X)` and `EdgeInsets` values. Common values seen throughout:

- `8`, `12`, `14`, `16`, `18`, `20`, `24`, `28` (padding/gaps)
- `4`, `6`, `10` (small gaps)
- `120`, `90` (bottom clearance magic numbers)

Without a spacing scale (e.g., `4, 8, 12, 16, 24, 32, 48`), there is no visual rhythm guarantee. Some screens use `SizedBox(height: 20)` while adjacent screens use `SizedBox(height: 24)` for visually similar gaps.

---

## Theme System

**Score: 3/10 — Minimal**

`MaterialApp` in `fit_flow.dart` uses:
```dart
theme: ThemeData(
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.backgroundScaffold,
),
```

This is extremely minimal ThemeData. Issues:
- No `ColorScheme` defined — Flutter M3 widgets will use the default color scheme, which may not match `AppColors`.
- No `TextTheme` — all text styles are applied manually via `AppTextStyles.X`. This means `Text` widgets using default style will use Flutter's default typography, not Inter.
- No `ElevatedButtonTheme` — every `ElevatedButton` defines its own `ElevatedButton.styleFrom(...)` inline. This is repetitive and inconsistent.
- No `InputDecorationTheme` — `CustomTextField` defines its borders inline, but other `TextField` usages (like the reauth dialog) use raw `TextField` with no style.
- No dark mode support.

---

## Recommendations

1. **Define `error` and `errorLight` in `AppColors`** and update `ErrorBanner` to use them.
2. **Remove duplicate color tokens**: Merge `fillColor` → `backgroundButton`, `secondaryColor` → `backgroundSecondary`, `borderButton` → `borderColor`.
3. **Separate colors from text styles**: Remove all color properties from `AppTextStyles` constants. Use `AppColors` at call sites.
4. **Rename text styles semantically** or add semantic aliases alongside the size-named ones.
5. **Create `AppSpacing` class**: `static const double xs = 4, sm = 8, md = 16, lg = 24, xl = 32`.
6. **Expand `ThemeData`**: Define a full `ColorScheme.fromSeed()` + `TextTheme` using Inter + `ElevatedButtonThemeData` + `InputDecorationTheme`.
7. **Add `Color(0xFF1A3FAB)` to `AppColors`** as `gradientEnd` or `primaryDark`.
