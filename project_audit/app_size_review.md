# App Size Review — FitFlow

## Asset Inventory

### Images (`assets/images/`)

| File | Type | Estimated Size | Usage |
|---|---|---|---|
| `treadmill.png` | PNG | ~50–150 KB | App launcher icon source |
| `exerciseRoutine.png` | PNG | ~50–200 KB | Unknown (not referenced in code) |
| `splashImage.png` | PNG | ~50–200 KB | Native splash (1024×1024) |
| `splashImageAndroid+12.png` | PNG | ~50–200 KB | Android 12+ splash (912×912) |
| `logo.png` | PNG | ~20–80 KB | App logo (referenced in `AppAssets`) |
| `authImage.svg` | SVG | ~5–30 KB | Auth screen hero image |
| `appleLogo.svg` | SVG | ~2–5 KB | Apple sign-in button |
| `googleLogo.svg` | SVG | ~2–5 KB | Google sign-in button |
| `questionIcon.svg` | SVG | ~1–5 KB | Unknown usage |

**Total image assets**: ~280–900 KB (rough estimate without reading binary sizes)

### Fonts (`assets/fonts/`)

| File | Weight |
|---|---|
| `Inter-Regular.ttf` | 400 |
| `Inter-Medium.ttf` | 500 |
| `Inter-SemiBold.ttf` | 600 |
| `Inter-Bold.ttf` | 700 |
| `Inter-ExtraBold.ttf` | 800 |

Inter is a variable-weight font family. Bundling 5 individual weight files adds approximately **1.5–2.5 MB** to the app bundle. The `ExtraBold` (800) weight is used in `AppTextStyles.extraBold26` and `extraBold30` — used in profile name display, dashboard header, and learn screen. If only a few spots use ExtraBold, consider removing it and using Bold (700) with a slight `fontSize` adjustment, saving ~400–500 KB.

---

## Unused Assets Analysis

### `exerciseRoutine.png`
This file is in `assets/images/` but does not appear to be referenced in any Dart file based on code review. The `AppAssets` file (`lib/core/utils/app_assets.dart`) is auto-generated — verify it references this file. If not referenced anywhere, remove it.

### `questionIcon.svg`
Referenced in `AppAssets` but its usage in the UI was not found during code review. Verify usage; remove if unused.

### `appleLogo.svg`
Apple Sign-In button asset — referenced in auth screen button rows. Apple sign-in is not implemented in the codebase (only Google and email/password). The SVG asset is bundled but the feature is absent. Remove the asset until Apple Sign-In is implemented.

---

## Dependency Weight Analysis

Estimated APK size contributions (debug + release build):

| Package | Estimated APK impact | Notes |
|---|---|---|
| Firebase suite (core + auth + firestore) | ~3–5 MB | Native code + Dart SDK |
| `google_sign_in` | ~1–1.5 MB | Google Play Services dependency |
| `flutter_svg` | ~300–500 KB | SVG parsing library |
| `image_picker` | ~300–500 KB | Native camera/gallery code |
| `persistent_bottom_nav_bar` | ~100–200 KB | Pure Dart |
| `flutter_animate` | ~100–200 KB | Pure Dart |
| `dartz` | ~100–200 KB | Pure Dart |
| `shimmer` | ~50–100 KB | Pure Dart |
| Inter fonts (5 weights) | ~1.5–2.5 MB | Bundled TTF files |

**Estimated minimum release APK**: ~12–18 MB (typical for Firebase + Google Sign-In apps)

---

## Image Format Optimization

### Current Issues

1. **Splash images are large PNGs**: `splashImage.png` (1024×1024) and `splashImageAndroid+12.png` (912×912) are square PNGs. Native splash screens compress these images, but the source files add to the bundle. Consider using WebP format for smaller file sizes (-25–35% vs PNG) while maintaining quality.

2. **No WebP for regular images**: `treadmill.png`, `logo.png`, and `exerciseRoutine.png` are PNG — convert to WebP for production.

3. **No multi-resolution image variants**: The `assets/images/` folder has single-resolution images. Flutter supports `2x/` and `3x/` subdirectories for density-specific images. Currently all devices get the same resolution image.

---

## Font Optimization Opportunities

1. **Remove `Inter-ExtraBold.ttf`** if usage is minimal (only profile + learn screen headers). Use `bold` weight with a slightly larger size.
2. **Consider variable font**: Inter Variable (`Inter-Variable.ttf`) is a single file replacing all 5 weight files, typically ~600–900 KB total vs 1.5–2.5 MB for individual files. Flutter supports variable fonts — this would save significant size.

---

## Code Size

The Dart code compiles to native ARM bytecode. At ~90 Dart files with moderate logic:
- Estimated compiled Dart code: ~500 KB–1 MB in release mode
- Tree-shaking in `flutter build --release` removes unused code

The `mocktail` package being in production dependencies (not dev_dependencies) means the mock library and its dependencies are compiled into the release build — adding unnecessary code size.

---

## Recommendations by Priority

### High Priority (immediate size impact)
1. **Delete `exerciseRoutine.png`** if unused — reduces bundle size.
2. **Delete `appleLogo.svg`** until Apple Sign-In is implemented.
3. **Move `mocktail` to `dev_dependencies`** — removes test library from release builds.

### Medium Priority
4. **Convert PNG images to WebP** — estimated 25–35% size reduction on images.
5. **Replace 5 Inter TTF files with Inter Variable** — estimated 40–60% font size reduction.
6. **Remove `Inter-ExtraBold.ttf`** if usage can be replaced by Bold + slightly larger size.

### Low Priority (polish)
7. **Add image resolution variants** (`2x/`, `3x/`) for density-appropriate rendering.
8. **Enable R8/ProGuard** on Android release builds for code minification (should be default in Flutter release builds).
9. **Consider deferred loading** for the Learn feature once it has real content — load on first tab visit.
