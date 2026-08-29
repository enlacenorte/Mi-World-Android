import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/neon_theme.dart';
import '../globe/globe_painter.dart';
import '../../core/i18n/localization_service.dart';
import '../../core/audio/sound_service.dart';

class TrainingScreen extends StatefulWidget {
  final LocalizationService loc;
  const TrainingScreen({super.key, required this.loc});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  Timer? _inactivityTimer;

  @override
  void initState() {
    super.initState();
    _resetInactivity();
  }

  void _resetInactivity() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(const Duration(seconds: 12), () {
      if (mounted) Navigator.pop(context);
    });
  }

  @override
  void dispose() {
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
              // Barra Superior Modo Entrenamiento
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        SoundService.playKeyClick();
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back, color: NeonTheme.cyan),
                      label: Text(t.t('trainExit'), style: const TextStyle(color: NeonTheme.cyan, fontWeight: FontWeight.bold)),
                    ),
                    Text(t.t('trainHudTitle'), style: const TextStyle(color: NeonTheme.gold, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                  ],
                ),
              ),

              // Globo de Exploración Libre
              Expanded(
                child: Center(
                  child: CustomPaint(
                    size: const Size(300, 300),
                    painter: GlobeCustomPainter(rotationLon: 30, rotationLat: 10, scale: 1.1),
                  ),
                ),
              ),

              // Ficha Informativa Flotante
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(14),
                decoration: NeonTheme.neonBoxDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('🇦🇷 Argentina', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: NeonTheme.cyan)),
                        Text('🕒 11:35 AM', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: NeonTheme.neonGreen)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text('Capital: Buenos Aires • Continente: América del Sur', style: TextStyle(color: Colors.white70)),
                    const Text('Población: ~46M • Moneda: Peso (\$)', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
