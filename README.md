# 🌍 My World Android (Flutter + GLSL Shaders)

<div align="center">

![My World Android Banner](https://img.shields.io/badge/🎮_My_World-Android_Native_App-00f3ff?style=for-the-badge)
[![GitHub Repository](https://img.shields.io/badge/📂_GitHub_Repo-enlacenorte/my--world--android-39ff14?style=for-the-badge&logo=github)](https://github.com/enlacenorte/my-world-android)
[![Web Version Live](https://img.shields.io/badge/🌐_Web_Version-myworld--play.vercel.app-ff007f?style=for-the-badge)](https://myworld-play.vercel.app)

### 🚀 **High-Fidelity 3D Vector Geography Quiz & Planetary Exploration Mobile Game for Kids & Schools**
> **Dedicated with all our ❤️ to Francisco Giudice**

[![Flutter](https://img.shields.io/badge/Flutter-3.x_Dart-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![GLSL Shaders](https://img.shields.io/badge/Graphics-GLSL_Fragment_Shaders-FF6F00)](https://github.com/enlacenorte/my-world-android)
[![5 Global Languages](https://img.shields.io/badge/Languages-EN_·_ES_·_JA_·_ZH_·_AR_(RTL)-ffe600)](https://github.com/enlacenorte/my-world-android)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

</div>

---

## 🌟 About "My World Android"

**My World Android** is the standalone, high-performance native mobile game counterpart to the lightweight single-file web game. Developed using **Flutter (Dart)** with custom **GLSL Fragment Shaders**, this edition is engineered specifically for Android devices (smartphones, tablets, and Chromebooks) to unlock high-fidelity visual effects, 60-120 FPS animations, sub-millisecond audio response, and advanced haptic tactile feedback.

---

## 🕹️ Key Features

* **3D Vector Globe with GLSL Atmosphere**: Real-time atmospheric Fresnel scatter shader (`atmosphere.frag`) and refractive explosion shockwave shader (`shockwave.frag`).
* **Automatic First Spin on Play**: Instant camera navigation to the first target nation via spherical Great-Circle slerp.
* **177 Sovereign Nations Atlas**: Detailed metadata (capitals, estimated population, independence/founding dates, currencies, high-res flags).
* **23 Interactive Oceans & Closed Seas**: Geodesic proximity detection and glowing boundary highlight rings.
* **🕒 Real-Time Local Clocks**: Live timezone digital clock for every capital city in the world.
* **🛸 Retro UFO Asteroids Mini-Game**: Floating alien targets awarding x2/x4 multipliers or triggering screen-shake plasma bombs.
* **🏆 Top 10 Hall of Fame**: Persistent local leaderboard with qualification gating.
* **⏳ Global 12-Second Inactivity Timer**: Returns cleanly to the welcome screen when idle.

---

## 🌐 5-Language Native Localization

| Language | Code | Script | Direction |
| :--- | :---: | :--- | :---: |
| **English** | `en` | Latin | LTR |
| **Spanish** | `es` | Latin | LTR |
| **Japanese** | `ja` | Kanji / Katakana | LTR |
| **Chinese** | `zh` | Simplified Hanzi | LTR |
| **Arabic** | `ar` | Arabic Script | **RTL** |

---

## 🛠️ Project Structure

```
mi-mundo-app/
├── assets/
│   ├── data/                   # atlas_5l.json, oceans_5l.json, trivia_155.json, countries-110m.json
│   ├── shaders/                # atmosphere.frag, shockwave.frag
│   └── audio/
├── lib/
│   ├── core/
│   │   ├── audio/              # SoundService
│   │   ├── i18n/               # LocalizationService (5 Languages + RTL)
│   │   └── timers/             # InactivityManager
│   ├── data/
│   │   ├── datasources/        # JsonAssetLoader
│   │   └── repositories/       # LeaderboardRepository
│   ├── domain/models/          # CountryModel, OceanModel, TriviaModel, ScoreRecordModel
│   ├── presentation/
│   │   ├── globe/              # GlobeCustomPainter & SphericalMath
│   │   ├── screens/            # SplashScreen, QuizScreen, TrainingScreen
│   │   └── theme/              # NeonTheme
│   └── main.dart               # App entrypoint
├── pubspec.yaml                # Flutter project configuration
├── spec.md                     # Spec Kit formal specification
├── plan.md                     # Technical architecture plan
└── tasks.md                    # Actionable task list
```

---

## 💻 Building the APK

```bash
# 1. Get dependencies
flutter pub get

# 2. Run locally in debug mode
flutter run

# 3. Build release APK
flutter build apk --release
```

---

## 📄 License

Distributed under the **MIT License**. Free for educational, personal, and classroom use.
