import 'package:flutter/material.dart';
import '../theme/neon_theme.dart';
import '../../core/i18n/localization_service.dart';
import '../../core/audio/sound_service.dart';
import 'quiz_screen.dart';
import 'training_screen.dart';
import 'passport_screen.dart';

class SplashScreen extends StatefulWidget {
  final LocalizationService loc;
  const SplashScreen({super.key, required this.loc});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2400))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.loc;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Selector de 5 Idiomas
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: ['es', 'en', 'ja', 'zh', 'ar'].map((lang) {
                    final isActive = t.currentLang == lang;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: ChoiceChip(
                        label: Text(lang.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, color: isActive ? Colors.black : Colors.white)),
                        selected: isActive,
                        selectedColor: NeonTheme.cyan,
                        backgroundColor: NeonTheme.surface,
                        onSelected: (_) {
                          SoundService.playKeyClick();
                          t.setLanguage(lang);
                        },
                      ),
                    );
                  }).toList(),
                ),

                // Globito Neón 3D con Pulso (+50% Escala)
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    final scale = 0.95 + 0.10 * _pulseController.value;
                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: NeonTheme.cyan, width: 3.5),
                          gradient: const RadialGradient(
                            colors: [Color(0x4400F3FF), Color(0xEA0A1636)],
                          ),
                          boxShadow: [
                            BoxShadow(color: NeonTheme.cyan.withOpacity(0.85), blurRadius: 40, spreadRadius: 4),
                            BoxShadow(color: NeonTheme.magenta.withOpacity(0.45), blurRadius: 70, spreadRadius: 2),
                          ],
                        ),
                        child: const Center(
                          child: Text('🌍', style: TextStyle(fontSize: 58)),
                        ),
                      ),
                    );
                  },
                ),

                // Cartel de Marquesina Neón (+50% Escala)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                  decoration: NeonTheme.marqueeBoxDecoration,
                  child: Text(
                    t.t('appTitle'),
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                      color: NeonTheme.gold,
                      shadows: [
                        Shadow(color: NeonTheme.gold, blurRadius: 16),
                        Shadow(color: Colors.orange, blurRadius: 28),
                      ],
                    ),
                  ),
                ),

                // Acceso a Pasaporte de Explorador
                OutlinedButton.icon(
                  onPressed: () {
                    SoundService.playKeyClick();
                    Navigator.push(context, MaterialPageRoute(builder: (_) => PassportScreen(loc: t)));
                  },
                  icon: const Icon(Icons.badge, color: NeonTheme.gold, size: 20),
                  label: const Text('🛂 MI PASAPORTE DE EXPLORADOR', style: TextStyle(color: NeonTheme.gold, fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: NeonTheme.gold, width: 1.8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),

                // Botones Jugar y Entrenar
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          SoundService.playKeyClick();
                          Navigator.push(context, MaterialPageRoute(builder: (_) => QuizScreen(loc: t)));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: NeonTheme.cyan,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 12,
                        ),
                        child: Text(t.t('playBtn'), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 2)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          SoundService.playKeyClick();
                          Navigator.push(context, MaterialPageRoute(builder: (_) => TrainingScreen(loc: t)));
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: NeonTheme.magenta,
                          side: const BorderSide(color: NeonTheme.magenta, width: 2),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: Text(t.t('trainBtn'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
