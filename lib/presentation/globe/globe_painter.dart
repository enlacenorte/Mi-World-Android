import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/neon_theme.dart';

class GlobeCustomPainter extends CustomPainter {
  final double rotationLon;
  final double rotationLat;
  final double scale;
  final bool isRedShockwave;
  final String? selectedCountryCode;
  final double pulseTime;

  GlobeCustomPainter({
    required this.rotationLon,
    required this.rotationLat,
    required this.scale,
    this.isRedShockwave = false,
    this.selectedCountryCode,
    this.pulseTime = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (math.min(size.width, size.height) / 2) * 0.82 * scale;

    // 1. Océano base con gradiente radial
    final oceanPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF0D2847),
          const Color(0xFF040A17),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, oceanPaint);

    // 2. Graticules (Meridianos y Paralelos)
    final gridPaint = Paint()
      ..color = NeonTheme.cyan.withOpacity(0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int lat = -60; lat <= 60; lat += 30) {
      final rLat = lat * math.pi / 180.0;
      final yOff = math.sin(rLat) * radius;
      final xRad = math.cos(rLat) * radius;
      canvas.drawOval(
        Rect.fromCenter(center: Offset(center.dx, center.dy - yOff * 0.4), width: xRad * 2, height: radius * 0.4),
        gridPaint,
      );
    }

    // 3. Resplandor exterior Neón
    final glowColor = isRedShockwave ? NeonTheme.alarmRed : NeonTheme.cyan;
    final glowPaint = Paint()
      ..color = glowColor.withOpacity(0.55 + 0.15 * math.sin(pulseTime * 3))
      ..style = PaintingStyle.stroke
      ..strokeWidth = isRedShockwave ? 5.0 : 3.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawCircle(center, radius, glowPaint);

    // Borde brillante nítido
    final borderPaint = Paint()
      ..color = glowColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(center, radius, borderPaint);
  }

  @override
  bool shouldRepaint(covariant GlobeCustomPainter oldDelegate) {
    return oldDelegate.rotationLon != rotationLon ||
           oldDelegate.rotationLat != rotationLat ||
           oldDelegate.scale != scale ||
           oldDelegate.isRedShockwave != isRedShockwave ||
           oldDelegate.pulseTime != pulseTime;
  }
}
