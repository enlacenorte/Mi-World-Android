import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/neon_theme.dart';
import '../globe/globe_3d_painter.dart';
import '../../core/i18n/localization_service.dart';
import '../../core/audio/sound_service.dart';
import '../../core/voice/voice_pronunciation_service.dart';
import '../../domain/models/passport_model.dart';

class QuizScreen extends StatefulWidget {
  final LocalizationService loc;
  const QuizScreen({super.key, required this.loc});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with SingleTickerProviderStateMixin {
  int _score = 0;
  int _streak = 0;
  int _lives = 3;
  int _timeLeft = 16;
  Timer? _gameTimer;
  Timer? _inactivityTimer;
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
    _resetInactivity();
    // Primer giro automático
    Future.delayed(const Duration(milliseconds: 350), () {
      _startNewRound();
    });
  }

  void _resetInactivity() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(const Duration(seconds: 12), () {
      if (mounted) Navigator.pop(context);
    });
  }

  void _startNewRound() {
    _resetInactivity();
    setState(() {
      _timeLeft = 16;
    });

    // Pronunciación por voz para los niños
    VoicePronunciationService.speakCountryAndCapital(
      countryName: 'Argentina',
      capitalName: 'Buenos Aires',
      lang: widget.loc.currentLang,
    );

    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() => _timeLeft--);
      } else {
        timer.cancel();
        _handleTimeout();
      }
    });
  }

  void _handleTimeout() {
    SoundService.playFailure();
    setState(() {
      _lives--;
      _streak = 0;
    });
    if (_lives <= 0) {
      _triggerGameOver();
    } else {
      _startNewRound();
    }
  }

  void _triggerGameOver() {
    _gameTimer?.cancel();
    _inactivityTimer?.cancel();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: NeonTheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: NeonTheme.cyan, width: 2)),
        title: Text(widget.loc.t('gameoverTitle'), style: const TextStyle(color: NeonTheme.alarmRed, fontWeight: FontWeight.bold)),
        content: Text('${widget.loc.t('finalScore')} $_score ${widget.loc.t('pointsWord')}', style: const TextStyle(color: Colors.white, fontSize: 18)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: Text(widget.loc.t('mainMenuBtn'), style: const TextStyle(color: NeonTheme.cyan, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    _gameTimer?.cancel();
    _inactivityTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.loc;
    return GestureDetector(
      onTap: _resetInactivity,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // HUD Superior
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('⭐ $_score', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: NeonTheme.cyan)),
                    Text('🔥 x$_streak', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: NeonTheme.gold)),
                    Row(
                      children: List.generate(3, (index) => Text(index < _lives ? '❤️' : '🖤', style: const TextStyle(fontSize: 18))),
                    ),
                  ],
                ),
              ),

              // Barra de Tiempo
              LinearProgressIndicator(
                value: _timeLeft / 16.0,
                backgroundColor: Colors.grey.shade900,
                valueColor: AlwaysStoppedAnimation<Color>(_timeLeft > 4 ? NeonTheme.cyan : NeonTheme.alarmRed),
                minHeight: 6,
              ),

              // Globo 3D con Nubes y Luces Nocturnas
              Expanded(
                child: Center(
                  child: AnimatedBuilder(
                    animation: _animController,
                    builder: (context, child) {
                      return CustomPaint(
                        size: const Size(290, 290),
                        painter: Globe3DPainter(
                          rotationLon: _animController.value * 360,
                          rotationLat: 15,
                          scale: 1.0,
                          pulseTime: _animController.value * 10,
                          cloudDrift: _animController.value * 2,
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Opciones Multiple Choice
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildOption('Buenos Aires', true)),
                        const SizedBox(width: 8),
                        Expanded(child: _buildOption('Montevideo', false)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: _buildOption('Santiago', false)),
                        const SizedBox(width: 8),
                        Expanded(child: _buildOption('Lima', false)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(String text, bool isCorrect) {
    return ElevatedButton(
      onPressed: () async {
        _resetInactivity();
        if (isCorrect) {
          SoundService.playCorrect();
          // Otorgar estampilla al pasaporte
          await PassportService.awardStamp(
            countryCode: 'ARG',
            countryName: 'Argentina',
            capital: 'Buenos Aires',
            continent: 'América del Sur',
          );
          setState(() {
            _score += 100 * (_streak >= 3 ? 2 : 1);
            _streak++;
          });
        } else {
          SoundService.playFailure();
          setState(() {
            _lives--;
            _streak = 0;
          });
        }
        if (_lives <= 0) {
          _triggerGameOver();
        } else {
          _startNewRound();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: NeonTheme.surface,
        foregroundColor: Colors.white,
        side: const BorderSide(color: NeonTheme.cyan, width: 1.5),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }
}
