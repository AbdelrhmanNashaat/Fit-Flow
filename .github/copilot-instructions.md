# FitFlow — GitHub Copilot Instructions

## Stack
Flutter · Dart · Firebase Auth · Firestore · get_it · flutter_bloc (Cubit) · SharedPreferences · path_provider

## Architecture Rules
- Feature-based Clean Architecture: `domain/`, `data/`, `presentation/` per feature.
- Use **Cubit** (not Bloc) for all state management. Sealed state classes only.
- `BlocProvider` at the view level; pass dependencies via constructor, never `getIt` in widgets.
- Named routes only — typed argument structs, never raw `Map` arguments.

## Code Style
- No comments unless the WHY is non-obvious.
- Always `const` constructors where possible.
- `copyWith` on every state class.
- `switch` with exhaustive matching on sealed states inside `BlocBuilder`.
- Never hardcode strings — use `context.l10n.<key>` (both EN + AR required).
- Never use raw `Color(0x...)` — use `AppColors.<semanticName>`.

## Colors (AppColors)
Semantic names: `backgroundScaffold`, `backgroundCard`, `textPrimary`, `textSecondary`,
`textTertiary`, `borderColor`, `dividerLight`, `primaryColor`, `buttonColor`,
`success`, `successLight`, `warning`, `warningLight`.

## Patterns to Follow
- Timer in Cubit: `Timer? _timer;` + cancel in `close()` override.
- Bottom sheets: static `show(BuildContext)` factory on the widget class.
- Repo errors: `Either<Failure, T>` for async IO; synchronous repos return plain types.
- Image storage: local files via `path_provider`, path in SharedPreferences keyed by uid.
