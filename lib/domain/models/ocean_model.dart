class OceanData {
  final String id;
  final double lon;
  final double lat;
  final double radiusDeg;
  final Map<String, LocalizedOcean> localized;

  const OceanData({
    required this.id,
    required this.lon,
    required this.lat,
    required this.radiusDeg,
    required this.localized,
  });

  LocalizedOcean getForLang(String lang) => localized[lang] ?? localized['en'] ?? localized.values.first;
}

class LocalizedOcean {
  final String name;
  final String type;
  final String area;
  final String depth;
  final String fact;

  const LocalizedOcean({
    required this.name,
    required this.type,
    required this.area,
    required this.depth,
    required this.fact,
  });

  factory LocalizedOcean.fromJson(Map<String, dynamic> json) {
    return LocalizedOcean(
      name: json['name'] as String? ?? '',
      type: json['type'] as String? ?? '',
      area: json['area'] as String? ?? '',
      depth: json['depth'] as String? ?? '',
      fact: json['fact'] as String? ?? '',
    );
  }
}
