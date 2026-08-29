import 'package:flutter/services.dart';

class SoundService {
  static bool muted = false;

  static void toggleMute() {
    muted = !muted;
  }

  static void playKeyClick() {
    if (muted) return;
    HapticFeedback.selectionClick();
  }

  static void playCorrect() {
    if (muted) return;
    HapticFeedback.mediumImpact();
  }

  static void playFailure() {
    if (muted) return;
    HapticFeedback.heavyImpact();
  }

  static void playUfoHit() {
    if (muted) return;
    HapticFeedback.vibrate();
  }

  static void playBombExplosion() {
    if (muted) return;
    HapticFeedback.heavyImpact();
  }
}
