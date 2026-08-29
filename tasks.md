# 📋 Implementation Tasks (Tasks Checklist)

- [ ] **Phase 1: Project Setup & Asset Configuration**
  - [x] Task 1.1: Initialize Spec Kit in `mi-mundo-app/`
  - [x] Task 1.2: Copy and verify datasets (`atlas_5l.json`, `oceans_5l.json`, `trivia_155.json`, `countries-110m.json`)
  - [ ] Task 1.3: Configure `pubspec.yaml` with asset declarations and dependencies

- [ ] **Phase 2: Core Domain & Data Layer**
  - [ ] Task 2.1: Implement Data Models (`CountryModel`, `OceanModel`, `TriviaModel`, `ScoreRecordModel`)
  - [ ] Task 2.2: Implement `JsonAssetLoader` & `AtlasRepository`
  - [ ] Task 2.3: Implement `LocalizationService` (100% native ES, EN, JA, ZH, AR)
  - [ ] Task 2.4: Implement `LeaderboardService` (Top 10 storage with qualification check)

- [ ] **Phase 3: Audio, Haptics & Shaders**
  - [ ] Task 3.1: Create GLSL Shaders (`atmosphere.frag`, `shockwave.frag`)
  - [ ] Task 3.2: Implement `SoundService` with retro sound effects and adaptive audio
  - [ ] Task 3.3: Implement `HapticFeedbackService`

- [ ] **Phase 4: 3D Vector Globe & Hit Testing**
  - [ ] Task 4.1: Implement `SphericalMath` (Orthographic projection & Great-Circle slerp)
  - [ ] Task 4.2: Implement `GlobeCustomPainter` with neon multi-pass rendering
  - [ ] Task 4.3: Implement Geodesic Hit Testing for Countries and 23 Oceans/Seas

- [ ] **Phase 5: UI Screens & Game Mechanics**
  - [ ] Task 5.1: Build `SplashScreen` with 50% enlarged pulsing globe and highway marquee sign
  - [ ] Task 5.2: Build `QuizScreen` with auto-spin, difficulty gauge, timers, and comic toasts
  - [ ] Task 5.3: Build `UfoOverlayWidget` (Asteroids mini-game bonus & bomb explosion)
  - [ ] Task 5.4: Build `TrainingScreen` with teletype console and live timezone clocks
  - [ ] Task 5.5: Build `Top10ScoreboardModal` and `TriviaPopupModal`
  - [ ] Task 5.6: Implement global 12-second `InactivityManager`

- [ ] **Phase 6: Verification & Packaging**
  - [ ] Task 6.1: Verify 5-language completeness and zero fallbacks
  - [ ] Task 6.2: Validate 60 FPS performance and touch response
