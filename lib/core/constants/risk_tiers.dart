/// Risk tiers from the 3-question quiz (prototype v9.2). The quiz output is
/// a RECOMMENDATION, not advice; the user can change it anytime, and every
/// deployment still requires explicit consent regardless of tier.
enum RiskTier {
  short,
  balanced,
  diversified;

  /// The exact string stored in `profiles.risk_tier`.
  String get dbValue => name;

  static RiskTier? fromDb(String? value) => switch (value) {
    'short' => RiskTier.short,
    'balanced' => RiskTier.balanced,
    'diversified' => RiskTier.diversified,
    _ => null,
  };
}

/// Majority answer wins; any tie falls back to balanced.
RiskTier recommendTier(List<RiskTier> answers) {
  if (answers.isEmpty) return RiskTier.balanced;
  final counts = <RiskTier, int>{};
  for (final answer in answers) {
    counts[answer] = (counts[answer] ?? 0) + 1;
  }
  final highest = counts.values.reduce((a, b) => a > b ? a : b);
  final leaders = counts.entries
      .where((entry) => entry.value == highest)
      .map((entry) => entry.key)
      .toList();
  return leaders.length == 1 ? leaders.single : RiskTier.balanced;
}
