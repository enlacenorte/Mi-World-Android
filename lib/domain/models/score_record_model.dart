class HighScoreRecord {
  final String initials;
  final int score;
  final String diff;

  const HighScoreRecord({
    required this.initials,
    required this.score,
    required this.diff,
  });

  Map<String, dynamic> toJson() => {
    'initials': initials,
    'score': score,
    'diff': diff,
  };

  factory HighScoreRecord.fromJson(Map<String, dynamic> json) => HighScoreRecord(
    initials: json['initials'] as String? ?? 'JUG1',
    score: (json['score'] as num?)?.toInt() ?? 0,
    diff: json['diff'] as String? ?? 'FAC',
  );
}
