import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../supabase/supabase_client.dart';
import 'auth_repository.dart';
import 'campaign_repository.dart';
import 'engagement_repository.dart';
import 'goal_repository.dart';
import 'investment_repository.dart';
import 'kyc_repository.dart';
import 'referral_repository.dart';
import 'wallet_repository.dart';
import 'welfare_repository.dart';

/// Controllers depend on these providers, never on Supabase directly.

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref.watch(supabaseClientOrNullProvider)),
);

final kycRepositoryProvider = Provider<KycRepository>(
  (ref) => KycRepository(ref.watch(supabaseClientOrNullProvider)),
);

final walletRepositoryProvider = Provider<WalletRepository>(
  (ref) => WalletRepository(ref.watch(supabaseClientOrNullProvider)),
);

final campaignRepositoryProvider = Provider<CampaignRepository>(
  (ref) => CampaignRepository(ref.watch(supabaseClientOrNullProvider)),
);

final investmentRepositoryProvider = Provider<InvestmentRepository>(
  (ref) => InvestmentRepository(ref.watch(supabaseClientOrNullProvider)),
);

final goalRepositoryProvider = Provider<GoalRepository>(
  (ref) => GoalRepository(ref.watch(supabaseClientOrNullProvider)),
);

final engagementRepositoryProvider = Provider<EngagementRepository>(
  (ref) => EngagementRepository(ref.watch(supabaseClientOrNullProvider)),
);

final zakatRepositoryProvider = Provider<ZakatRepository>(
  (ref) => ZakatRepository(ref.watch(supabaseClientOrNullProvider)),
);

final sadaqahRepositoryProvider = Provider<SadaqahRepository>(
  (ref) => SadaqahRepository(ref.watch(supabaseClientOrNullProvider)),
);

final referralRepositoryProvider = Provider<ReferralRepository>(
  (ref) => ReferralRepository(ref.watch(supabaseClientOrNullProvider)),
);
