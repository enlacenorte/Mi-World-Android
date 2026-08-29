class CountryData {
  final String name;
  final String capital;
  final String continent;
  final String indep;
  final String pop;
  final String lang;
  final List<String> distractors;
  final String? currency;
  final String? timezone;

  const CountryData({
    required this.name,
    required this.capital,
    required this.continent,
    required this.indep,
    required this.pop,
    required this.lang,
    required this.distractors,
    this.currency,
    this.timezone,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) {
    return CountryData(
      name: json['name'] as String? ?? '',
      capital: json['capital'] as String? ?? '',
      continent: json['continent'] as String? ?? '',
      indep: json['indep'] as String? ?? '',
      pop: json['pop'] as String? ?? '',
      lang: json['lang'] as String? ?? '',
      distractors: (json['distractors'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      currency: json['currency'] as String?,
      timezone: json['timezone'] as String?,
    );
  }
}

class CountryFeature {
  final String code;
  final Map<String, CountryData> localized;
  final double centerLon;
  final double centerLat;

  const CountryFeature({
    required this.code,
    required this.localized,
    required this.centerLon,
    required this.centerLat,
  });

  CountryData getForLang(String lang) => localized[lang] ?? localized['en'] ?? localized.values.first;
}
