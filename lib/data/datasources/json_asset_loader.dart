import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/models/country_model.dart';
import '../../domain/models/ocean_model.dart';
import '../../domain/models/trivia_model.dart';

class JsonAssetLoader {
  static Future<Map<String, CountryFeature>> loadCountries() async {
    final str = await rootBundle.loadString('assets/data/atlas_5l.json');
    final Map<String, dynamic> raw = json.decode(str);
    final Map<String, CountryFeature> result = {};

    raw.forEach((code, value) {
      final mapVal = value as Map<String, dynamic>;
      final localized = <String, CountryData>{};
      mapVal.forEach((langKey, langVal) {
        if (langVal is Map<String, dynamic>) {
          localized[langKey] = CountryData.fromJson(langVal);
        }
      });
      result[code] = CountryFeature(
        code: code,
        localized: localized,
        centerLon: 0.0,
        centerLat: 0.0,
      );
    });
    return result;
  }

  static Future<List<OceanData>> loadOceans() async {
    final str = await rootBundle.loadString('assets/data/oceans_5l.json');
    final List<dynamic> raw = json.decode(str);
    return raw.map((item) {
      final map = item as Map<String, dynamic>;
      final locMap = <String, LocalizedOcean>{};
      final rawLoc = map['localized'] as Map<String, dynamic>? ?? {};
      rawLoc.forEach((k, v) {
        locMap[k] = LocalizedOcean.fromJson(v as Map<String, dynamic>);
      });
      return OceanData(
        id: map['id'] as String? ?? '',
        lon: (map['lon'] as num?)?.toDouble() ?? 0.0,
        lat: (map['lat'] as num?)?.toDouble() ?? 0.0,
        radiusDeg: (map['radiusDeg'] as num?)?.toDouble() ?? 10.0,
        localized: locMap,
      );
    }).toList();
  }

  static Future<List<TriviaItem>> loadTrivias() async {
    final str = await rootBundle.loadString('assets/data/trivia_155.json');
    final List<dynamic> raw = json.decode(str);
    return raw.map((e) => TriviaItem.fromJson(e as Map<String, dynamic>)).toList();
  }
}
