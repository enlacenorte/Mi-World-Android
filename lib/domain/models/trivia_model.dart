class TriviaItem {
  final Map<String, String> localized;

  const TriviaItem({required this.localized});

  factory TriviaItem.fromJson(Map<String, dynamic> json) {
    return TriviaItem(
      localized: json.map((key, value) => MapEntry(key, value.toString())),
    );
  }

  String getText(String lang) => localized[lang] ?? localized['en'] ?? localized['es'] ?? '';
}
