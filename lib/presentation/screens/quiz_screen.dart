import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/neon_theme.dart';
import '../globe/globe_painter.dart';
import '../../core/i18n/localization_service.dart';
import '../../core/audio/sound_service.dart';

class QuizScreen extends StatefulWidget {
  final LocalizationService loc;
  const QuizScreen({super.key, required this.loc});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _score = 0;
  int _streak = 0;
  int _lives = 3;
  int _timeLeft = 16;
  Timer? _gameTimer;
  Timer? _inactivityTimer;

  @override
  void initState() {
    super.initState();
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

              // Globo 3D
              Expanded(
                child: Center(
                  child: CustomPaint(
                    size: const Size(280, 280),
                    painter: GlobeCustomPainter(rotationLon: 0, rotationLat: 15, scale: 1.0),
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
      onPressed: () {
        _resetInactivity();
        if (isCorrect) {
          SoundService.playCorrect();
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
