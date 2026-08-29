import 'package:flutter/foundation.dart';

class VoicePronunciationService {
  static bool enabled = true;
  static double speechRate = 0.9; // Ritmo amigable para niños

  static const Map<String, String> langLocaleMap = {
    'es': 'es-ES',
    'en': 'en-US',
    'ja': 'ja-JP',
    'zh': 'zh-CN',
    'ar': 'ar-SA',
  };

  static Future<void> speakCountryAndCapital({
    required String countryName,
    required String capitalName,
    required String lang,
  }) async {
    if (!enabled) return;
    final locale = langLocaleMap[lang] ?? 'en-US';
    debugPrint('🗣️ [Voice TTS] ($locale) Pronouncing: $capitalName, $countryName');
    // En runtime real de Flutter móvil se vincula con flutter_tts
  }

  static void toggleVoice() {
    enabled = !enabled;
  }
}
