import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart';

class SphericalMath {
  static Vector3 toCartesian(double lonDeg, double latDeg, double radius) {
    final lonRad = lonDeg * math.pi / 180.0;
    final latRad = latDeg * math.pi / 180.0;
    return Vector3(
      radius * math.cos(latRad) * math.cos(lonRad),
      radius * math.sin(latRad),
      radius * math.cos(latRad) * math.sin(lonRad),
    );
  }

  static double greatCircleDistance(double lon1, double lat1, double lon2, double lat2) {
    final p1 = lon1 * math.pi / 180.0;
    final l1 = lat1 * math.pi / 180.0;
    final p2 = lon2 * math.pi / 180.0;
    final l2 = lat2 * math.pi / 180.0;
    return math.acos(math.sin(l1) * math.sin(l2) + math.cos(l1) * math.cos(l2) * math.cos(p2 - p1));
  }
}
