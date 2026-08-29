# 🏗️ Architecture & Implementation Plan
## Mi Mundo Native Flutter App

---

### 1. Architectural Pattern
- **Clean Architecture + Provider / Riverpod State Management**:
  - `data/`: Repositories loading `atlas_5l.json`, `oceans_5l.json`, `trivia_155.json`, `countries-110m.json`.
  - `domain/`: Models (`Country`, `Ocean`, `Trivia`, `ScoreRecord`), business rules, and quiz generators.
  - `presentation/`:
    - `screens/`: Splash, Quiz Game, Exploration/Training, Scoreboard Modal, Trivia Popup.
    - `widgets/`: GlobeCanvas (CustomPainter + GLSL Shaders), TeletypeBar, DifficultyGauge, UfoOverlay, ConfettiOverlay.
    - `theme/`: Cyberpunk Neon Color Palettes, Glow Decorators, Custom Font Styles.
  - `core/`: Audio synthesis & sound player, haptics manager, inactivity timer, localization engine.

---

### 2. File & Directory Layout

```
mi-mundo-app/
├── assets/
│   ├── data/                   # JSON datasets (177 countries, 23 seas, 155 trivias, TopoJSON)
│   ├── shaders/                # GLSL fragment shaders (atmosphere.frag, shockwave.frag)
│   └── audio/                  # Chiptune audio samples
├── lib/
│   ├── core/
│   │   ├── audio/              # SoundManager (SFX + Adaptive BGM)
│   │   ├── haptics/            # DeviceHapticService
│   │   ├── i18n/               # LocalizationService (ES, EN, JA, ZH, AR)
│   │   └── timers/             # InactivityManager
│   ├── data/
│   │   ├── datasources/        # JsonAssetLoader
│   │   └── repositories/       # AtlasRepository, LeaderboardRepository
│   ├── domain/
│   │   └── models/             # CountryModel, OceanModel, TriviaModel, HighScoreModel
│   ├── presentation/
│   │   ├── globe/              # Globe3DPainter, SphericalProjection, HitTester
│   │   ├── screens/            # SplashScreen, QuizScreen, TrainingScreen
│   │   ├── widgets/            # UfoWidget, TeletypeWidget, ScoreboardWidget
│   │   └── theme/              # NeonTheme, BulbMarqueeSign
│   └── main.dart               # App entrypoint
├── pubspec.yaml                # Flutter project configuration
└── spec.md / plan.md / tasks.md
```

---

### 3. GLSL Shader Specifications
1. **Atmosphere Glow (`atmosphere.frag`)**:
   - Computes Fresnel rim lighting around the sphere boundary to create a vibrant neon atmosphere halo.
2. **Bomb Shockwave (`shockwave.frag`)**:
   - Applies UV screen-space refraction distortion radiating from the bomb detonation center for 2 seconds.
