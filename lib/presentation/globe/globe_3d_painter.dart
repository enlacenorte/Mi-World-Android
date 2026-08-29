import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/neon_theme.dart';

class Globe3DPainter extends CustomPainter {
  final double rotationLon;
  final double rotationLat;
  final double scale;
  final double altitudeDive; // 1.0 (órbita) a 2.4 (vuelo rasante)
  final bool isRedShockwave;
  final double pulseTime;
  final double cloudDrift;
  final String? highlightedCountry;

  Globe3DPainter({
    required this.rotationLon,
    required this.rotationLat,
    this.scale = 1.0,
    this.altitudeDive = 1.0,
    this.isRedShockwave = false,
    this.pulseTime = 0.0,
    this.cloudDrift = 0.0,
    this.highlightedCountry,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final effectiveRadius = (math.min(size.width, size.height) / 2) * 0.84 * scale * altitudeDive;

    // 1. Océano Profundo con iluminación esférica 3D
    final oceanShader = RadialGradient(
      center: const Alignment(-0.35, -0.35),
      radius: 0.95,
      colors: [
        const Color(0xFF1E5B94), // Lado iluminado por el Sol
        const Color(0xFF0C2B4E),
        const Color(0xFF030A14), // Lado nocturno profundo
      ],
      stops: const [0.0, 0.55, 1.0],
    ).createShader(Rect.fromCircle(center: center, radius: effectiveRadius));

    final oceanPaint = Paint()..shader = oceanShader;
    canvas.drawCircle(center, effectiveRadius, oceanPaint);

    // 2. Luces de Ciudades en el Lado Nocturno (City Lights at Night)
    final nightCityPaint = Paint()
      ..color = NeonTheme.gold.withOpacity(0.42 + 0.12 * math.sin(pulseTime * 4))
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.5);

    // Render de racimos urbanos nocturnos simulados
    final random = math.Random(42);
    for (int i = 0; i < 45; i++) {
      final angle = random.nextDouble() * math.pi * 2;
      final dist = (random.nextDouble() * 0.75 + 0.15) * effectiveRadius;
      final cityX = center.dx + math.cos(angle + rotationLon * 0.01) * dist;
      final cityY = center.dy + math.sin(angle + rotationLat * 0.01) * dist * 0.6;
      if ((cityX - center.dx) > 0) { // Lado este/nocturno
        canvas.drawCircle(Offset(cityX, cityY), random.nextDouble() * 2.2 + 1.0, nightCityPaint);
      }
    }

    // 3. Graticules Esféricos Neón
    final gridPaint = Paint()
      ..color = (isRedShockwave ? NeonTheme.alarmRed : NeonTheme.cyan).withOpacity(0.20)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int lat = -60; lat <= 60; lat += 30) {
      final rLat = lat * math.pi / 180.0;
      final yOff = math.sin(rLat) * effectiveRadius;
      final xRad = math.cos(rLat) * effectiveRadius;
      canvas.drawOval(
        Rect.fromCenter(center: Offset(center.dx, center.dy - yOff * 0.45), width: xRad * 2, height: effectiveRadius * 0.45),
        gridPaint,
      );
    }

    // 4. Capa de Nubes Volumétricas en Deriva (Cloud Drift Layer)
    final cloudPaint = Paint()
      ..color = Colors.white.withOpacity(0.22)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    for (int i = 0; i < 8; i++) {
      final cloudAngle = (i * 45.0 + cloudDrift * 20.0) * math.pi / 180.0;
      final cX = center.dx + math.cos(cloudAngle) * effectiveRadius * 0.72;
      final cY = center.dy + math.sin(cloudAngle * 0.5) * effectiveRadius * 0.35;
      canvas.drawOval(
        Rect.fromCenter(center: Offset(cX, cY), width: 60 * scale, height: 24 * scale),
        cloudPaint,
      );
    }

    // 5. Atmósfera Neón con Resplandor Sci-Fi
    final atmosphereGlowColor = isRedShockwave ? NeonTheme.alarmRed : NeonTheme.cyan;
    final atmospherePaint = Paint()
      ..color = atmosphereGlowColor.withOpacity(0.65 + 0.18 * math.sin(pulseTime * 2.8))
      ..style = PaintingStyle.stroke
      ..strokeWidth = isRedShockwave ? 6.0 : 3.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16);
    canvas.drawCircle(center, effectiveRadius, atmospherePaint);

    // Borde nítido exterior
    final rimPaint = Paint()
      ..color = atmosphereGlowColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2;
    canvas.drawCircle(center, effectiveRadius, rimPaint);
  }

  @override
  bool shouldRepaint(covariant Globe3DPainter oldDelegate) {
    return oldDelegate.rotationLon != rotationLon ||
           oldDelegate.rotationLat != rotationLat ||
           oldDelegate.scale != scale ||
           oldDelegate.altitudeDive != altitudeDive ||
           oldDelegate.isRedShockwave != isRedShockwave ||
           oldDelegate.pulseTime != pulseTime ||
           oldDelegate.cloudDrift != cloudDrift;
  }
}
