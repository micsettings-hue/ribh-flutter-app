import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/result/result.dart';
import '../../data/models/models.dart';
import '../../data/repositories/providers.dart';

part 'marketplace_controller.g.dart';

enum MarketFilter { all, open, matured, saved }

class MarketplaceData {
  const MarketplaceData({required this.campaigns, required this.savedIds});

  final List<Campaign> campaigns;
  final Set<String> savedIds;

  MarketplaceData copyWith({
    List<Campaign>? campaigns,
    Set<String>? savedIds,
  }) => MarketplaceData(
    campaigns: campaigns ?? this.campaigns,
    savedIds: savedIds ?? this.savedIds,
  );

  /// Filter plus case-insensitive search over title, sector, and contract.
  List<Campaign> visible(MarketFilter filter, String query) {
    final q = query.trim().toLowerCase();
    return campaigns
        .where((c) {
          final passesFilter = switch (filter) {
            MarketFilter.all => true,
            MarketFilter.open => c.status == CampaignStatus.open,
            MarketFilter.matured => c.status == CampaignStatus.matured,
            MarketFilter.saved => savedIds.contains(c.id),
          };
          if (!passesFilter) return false;
          if (q.isEmpty) return true;
          return c.title.toLowerCase().contains(q) ||
              c.sector.toLowerCase().contains(q) ||
              c.contract.toLowerCase().contains(q);
        })
        .toList(growable: false);
  }
}

@riverpod
class MarketplaceController extends _$MarketplaceController {
  @override
  Future<MarketplaceData> build() async {
    final repo = ref.watch(campaignRepositoryProvider);
    final results = await Future.wait([repo.campaigns(), repo.myWatchlist()]);
    return MarketplaceData(
      campaigns: results[0].fold(
        (value) => value as List<Campaign>,
        (failure) => throw failure,
      ),
      savedIds: results[1].fold(
        (value) => value as Set<String>,
        (failure) => throw failure,
      ),
    );
  }

  /// Persists the bookmark, then updates the saved set in place so the
  /// toggle feels immediate without refetching the marketplace.
  Future<Result<void>> toggleSaved(String campaignId) async {
    final data = switch (state) {
      AsyncData(:final value) => value,
      _ => null,
    };
    if (data == null) return const Ok(null);
    final repo = ref.read(campaignRepositoryProvider);
    final saved = data.savedIds.contains(campaignId);
    final result = saved
        ? await repo.removeFromWatchlist(campaignId)
        : await repo.saveToWatchlist(campaignId);
    if (result.isOk) {
      final ids = Set<String>.of(data.savedIds);
      saved ? ids.remove(campaignId) : ids.add(campaignId);
      state = AsyncData(data.copyWith(savedIds: ids));
    }
    return result;
  }
}
