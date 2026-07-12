/// Referral points vocabulary. Mirrors the redeem_referral_tree RPC in
/// supabase/migrations/20260712000800_services.sql; keep them in lockstep.
/// Rewards are trees, never cash or fee credit (Riba guardrail).
library;

/// Points for a referral that signed up but is not yet verified.
const int pointsPerJoinedReferral = 10;

/// Total points for a referral once verified (10 joined + 40 verification).
const int pointsPerVerifiedReferral = 50;

/// One tree pledge costs this many points.
const int treeCostPoints = 50;

int referralPoints({required int joined, required int verified}) =>
    joined * pointsPerJoinedReferral + verified * pointsPerVerifiedReferral;

/// Trees still redeemable given total points and pledges already made.
int redeemableTrees({required int points, required int alreadyRedeemed}) {
  final earned = points ~/ treeCostPoints;
  final left = earned - alreadyRedeemed;
  return left < 0 ? 0 : left;
}
