# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

BestShot is an iOS-only Flutter app for selecting "best shots" from a photo library and generating clean collage outputs. It is fully local (no backend, no accounts, no cloud sync). The app flow is: Onboarding → Photo Picker → Swipe Review → Kept Grid → Layout Selection → Export.

- **Bundle ID:** `com.douggy.bestshot`
- **Min SDK:** Dart 3.11+, iOS 17+
- **UI framework:** CupertinoApp (not MaterialApp) with light/dark theme support
- **State management:** Riverpod (code-gen with `@riverpod` annotations)
- **Navigation:** go_router (defined in `lib/core/router/app_router.dart`)
- **Data models:** Freezed (`@freezed` annotations)
- **Localization:** ARB-based (`lib/l10n/`, template: `app_en.arb`)

## Common Commands

```bash
# Run the app (iOS only)
flutter run

# Run code generation (Riverpod providers, Freezed models)
dart run build_runner build --delete-conflicting-outputs

# Static analysis
flutter analyze

# Run tests
flutter test

# Run a single test file
flutter test test/path_to_test.dart

# Install iOS native dependencies
cd ios && pod install && cd ..

# Build iOS debug
flutter build ios --debug

# Verify home widget Xcode setup
bash scripts/verify_widget_setup.sh
```

## Architecture

### Directory Structure

```
lib/
├── main.dart                    # Entry point, ProviderScope, CupertinoApp.router
├── core/
│   ├── collage/                 # CustomPainter-based collage renderers (1×4, 2×2)
│   │   ├── painters/            # Layout-specific CustomPainter implementations
│   │   └── widgets/             # RepaintBoundary export pipeline widgets
│   ├── constants/               # App-wide constants
│   ├── router/app_router.dart   # All GoRouter route definitions
│   ├── theme/                   # CupertinoThemeData (app_theme.dart, app_colors.dart)
│   ├── ui/                      # Shared adaptive layout metrics
│   ├── utils/                   # Utility functions
│   ├── widget/                  # iOS home screen widget service (WidgetKit bridge)
│   └── extensions/              # Dart extension methods
├── features/                    # Feature modules (each follows data/domain/presentation)
│   ├── onboarding/              # First-launch gate, intro, 3-step onboarding
│   ├── photo_picker/            # photo_manager integration, thumbnail grid, permissions
│   ├── swipe_review/            # Swipe right=Keep, left=Skip, undo, 4-keep cap
│   ├── kept_grid/               # Display 4 kept photos
│   ├── layout_selection/        # 1×4 vs 2×2 layout preview cards
│   ├── export/                  # Caption input, aspect ratio picker, save/share
│   ├── collage/                 # Collage preview page
│   └── home/                    # Home screen with feature cards
├── l10n/                        # Generated localization files
└── shared/widgets/              # Shared widget components
```

### Feature Module Pattern

Each feature under `lib/features/<name>/` follows a three-layer structure:
- **`data/`** — Repositories, data sources
- **`domain/`** — Freezed models, business logic
- **`presentation/`** — Pages, Riverpod providers (code-gen `.g.dart` files)

### Key Architectural Decisions

- **Thumbnails for browsing, full-res only at export** — `photo_manager` loads thumbnails in picker/review; full-resolution images are loaded only during collage rendering to avoid UI freezes.
- **Collage rendering** uses `CustomPainter` + `RepaintBoundary.toImage()` pipeline in `core/collage/`. Export targets: 1080×1350 (4:5), 1080×1080 (1:1), 1080×1920 (9:16).
- **Route data passing** — Selected photos (`List<SelectedPhoto>`) are passed between screens via `GoRouter`'s `extra` parameter.
- **Persistence** — `shared_preferences` stores last layout choice, last export preset, and onboarding completion flag. No database.
- **iOS Home Widget** — Uses `home_widget` package to bridge Flutter data to a SwiftUI WidgetKit extension via App Groups (`group.com.douggy.bestshot`). See `WIDGET_SETUP.md` for Xcode configuration.

### Code Generation

Generated files (`*.g.dart`, `*.freezed.dart`) are excluded from analysis. After modifying any `@riverpod` provider or `@freezed` model, run:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Linting

Uses `flutter_lints` + `custom_lint` + `riverpod_lint`. Key rules enforced: `prefer_single_quotes`, `avoid_print`, `always_use_package_imports`, `prefer_const_constructors`, `prefer_final_locals`.

## Agent System

This project uses specialized Claude Code sub-agents (defined in `.claude/agents/` and `AGENTS.md`):
- **project-scaffolder** — One-time project setup and folder scaffolding
- **flutter-ui-builder** — Screens, Riverpod state, navigation wiring
- **collage-composer** — CustomPainter rendering, caption baking, export pipeline
- **flutter-test-architect** — Test-only agent, never modifies production code
- **appstore-compliance-reviewer** — App Store guideline review, produces `APPSTORE_CHECKLIST.md`

All agents use `TODO.md` as the shared progress tracker.
