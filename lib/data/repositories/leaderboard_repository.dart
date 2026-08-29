import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/score_record_model.dart';

class LeaderboardRepository {
  static const String _key = 'MY_WORLD_HIGHSCORES_TOP10';

  static final List<HighScoreRecord> defaultLeaderboard = [
    const HighScoreRecord(initials: "MAGL", score: 1850, diff: "EXP"),
    const HighScoreRecord(initials: "COLB", score: 1600, diff: "EXP"),
    const HighScoreRecord(initials: "FRAN", score: 1350, diff: "EXP"),
    const HighScoreRecord(initials: "MARP", score: 1100, diff: "MED"),
    const HighScoreRecord(initials: "ALEX", score: 950, diff: "MED"),
    const HighScoreRecord(initials: "GIUD", score: 800, diff: "MED"),
    const HighScoreRecord(initials: "NEON", score: 650, diff: "FAC"),
    const HighScoreRecord(initials: "AMER", score: 500, diff: "FAC"),
    const HighScoreRecord(initials: "CAPS", score: 380, diff: "FAC"),
    const HighScoreRecord(initials: "GEO1", score: 250, diff: "FAC"),
  ];

  Future<List<HighScoreRecord>> getScores() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_key);
      if (raw != null) {
        final List<dynamic> list = json.decode(raw);
        final parsed = list.map((e) => HighScoreRecord.fromJson(e as Map<String, dynamic>)).toList();
        if (parsed.isNotEmpty) {
          final combined = [...parsed];
          for (final d in defaultLeaderboard) {
            if (combined.length < 10) combined.push(d);
          }
          combined.sort((a, b) => b.score.compareTo(a.score));
          return combined.take(10).toList();
        }
      }
    } catch (_) {}
    return List.from(defaultLeaderboard);
  }

  Future<void> saveScore(String initials, int score, String diff) async {
    final cleanInitials = (initials.trim().isEmpty ? 'JUG1' : initials.trim()).toUpperCase().padRight(4, '_').substring(0, 4);
    final current = await getScores();
    current.add(HighScoreRecord(initials: cleanInitials, score: score, diff: diff));
    current.sort((a, b) => b.score.compareTo(a.score));
    final top10 = current.take(10).toList();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, json.encode(top10.map((e) => e.toJson()).toList()));
  }

  bool qualifiesForTop10(int score, List<HighScoreRecord> currentScores) {
    if (score <= 0) return false;
    if (currentScores.length < 10) return true;
    return score > currentScores.last.score;
  }
}
