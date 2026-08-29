# 🌍 Mi Mundo (My World) - Android Native App (Flutter + GLSL)
## Feature Specification (Spec)

---

### 1. Vision & Executive Summary
**Mi Mundo Native App** is the standalone, high-fidelity mobile application counterpart to the lightweight single-file web game. Developed in **Flutter (Dart)** with **GLSL Fragment Shaders**, this native app unlocks rich visual fidelity, fluid 120 Hz animations, high-definition audio, spatial 3D globe rendering, advanced haptics, and offline persistence on Android devices.

---

### 2. Functional Requirements

#### 2.1 Game Modes
1. **World Capitals Quiz**:
   - Automatic spherical camera spin (*Great-Circle interpolation*) to target country.
   - 4 multiple-choice options with regional distractors.
   - 3 difficulty levels with responsive countdown bars (Easy: 16s, Medium: 10s, Expert: 5s with visual/audio emergency alarms).
   - Retro UFO mini-game (Asteroids bonus) awarding x2/x4 multipliers or triggering 2-second screen tremors and globe alarms.
   - Hall of Fame (Top 10 Leaderboard) with persistent storage and strict qualification gating.
   - Global 12-second inactivity return timer.
2. **Planetary Exploration Mode (Training)**:
   - Free-spin vector globe with pinch-to-zoom and inertial panning.
   - 177 sovereign nations with complete metadata (capitals, population, continent, languages, independence, currencies, high-res flags).
   - Real-time live local clocks per country based on IANA timezones.
   - 23 interactive closed seas and oceans with highlighted glowing rings.
   - Teletype console with mechanical microswitch audio effects.

#### 2.2 Multilingual System (5 Languages)
- Native localization without cross-language fallback text:
  - 🇪🇸 Spanish (`es`)
  - 🇬🇧 English (`en`)
  - 🇯🇵 Japanese (`ja`)
  - 🇨🇳 Chinese (`zh`)
  - 🇸🇦 Arabic (`ar` with native RTL layout and typography)

#### 2.3 Visual & Audio Enhancements (App-Exclusive)
- **GLSL Shaders**:
  - Real-time atmosphere scattering and neon bloom shaders.
  - Interactive ripple / shockwave distortion on UFO bomb explosions.
- **Audio Engine**:
  - High-fidelity synthesized and sampled audio effects with sub-millisecond latency.
  - Adaptive synthwave background music reacting dynamically to player streak level.
- **Haptic Feedback**: Multi-level tactile vibrations (`HapticFeedback.lightImpact`, `heavyImpact`, and custom patterns).

---

### 3. Non-Functional Requirements
- **Target OS**: Android 8.0+ (API 26+) up to Android 15+.
- **Frame Rate**: Locked 60-120 FPS with hardware acceleration.
- **Offline First**: 100% playable without an internet connection.
- **Zero Privacy Footprint**: No tracking, no user login, no third-party ads.
