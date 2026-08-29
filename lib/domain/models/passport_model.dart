import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PassportStamp {
  final String countryCode;
  final String countryName;
  final String capital;
  final String continent;
  final DateTime unlockedAt;
  final int timesMastered;

  const PassportStamp({
    required this.countryCode,
    required this.countryName,
    required this.capital,
    required this.continent,
    required this.unlockedAt,
    this.timesMastered = 1,
  });

  Map<String, dynamic> toJson() => {
    'countryCode': countryCode,
    'countryName': countryName,
    'capital': capital,
    'continent': continent,
    'unlockedAt': unlockedAt.toIso8601String(),
    'timesMastered': timesMastered,
  };

  factory PassportStamp.fromJson(Map<String, dynamic> json) => PassportStamp(
    countryCode: json['countryCode'] as String? ?? '',
    countryName: json['countryName'] as String? ?? '',
    capital: json['capital'] as String? ?? '',
    continent: json['continent'] as String? ?? '',
    unlockedAt: DateTime.tryParse(json['unlockedAt'] as String? ?? '') ?? DateTime.now(),
    timesMastered: (json['timesMastered'] as num?)?.toInt() ?? 1,
  );
}

class PassportService {
  static const String _storageKey = 'MY_WORLD_PASSPORT_STAMPS';
  static final Map<String, PassportStamp> _stamps = {};

  static Map<String, PassportStamp> get stamps => Map.unmodifiable(_stamps);
  static int get totalMasteredCountries => _stamps.length;

  static Future<void> loadPassport() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_storageKey);
      if (raw != null) {
        final Map<String, dynamic> map = json.decode(raw);
        _stamps.clear();
        map.forEach((k, v) {
          _stamps[k] = PassportStamp.fromJson(v as Map<String, dynamic>);
        });
      }
    } catch (_) {}
  }

  static Future<bool> awardStamp({
    required String countryCode,
    required String countryName,
    required String capital,
    required String continent,
  }) async {
    final isNew = !_stamps.containsKey(countryCode);
    final count = isNew ? 1 : (_stamps[countryCode]!.timesMastered + 1);

    _stamps[countryCode] = PassportStamp(
      countryCode: countryCode,
      countryName: countryName,
      capital: capital,
      continent: continent,
      unlockedAt: DateTime.now(),
      timesMastered: count,
    );

    try {
      final prefs = await SharedPreferences.getInstance();
      final map = _stamps.map((k, v) => MapEntry(k, v.toJson()));
      await prefs.setString(_storageKey, json.encode(map));
    } catch (_) {}

    return isNew;
  }

  static double getContinentProgress(String continent, int totalInContinent) {
    if (totalInContinent <= 0) return 0.0;
    final inCont = _stamps.values.where((s) => s.continent.toLowerCase().contains(continent.toLowerCase())).length;
    return (inCont / totalInContinent).clamp(0.0, 1.0);
  }
}
