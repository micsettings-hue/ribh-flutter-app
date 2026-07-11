import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'auto_invest_queue_item.freezed.dart';
part 'auto_invest_queue_item.g.dart';

/// A queued auto-invest proposal. Nothing deploys while [QueueStatus.pending];
/// deployment only follows an explicit user approval.
@freezed
abstract class AutoInvestQueueItem with _$AutoInvestQueueItem {
  const factory AutoInvestQueueItem({
    required String id,
    required String ruleId,
    required String campaignId,
    required QueueStatus status,
    required DateTime createdAt,
  }) = _AutoInvestQueueItem;

  factory AutoInvestQueueItem.fromJson(Map<String, dynamic> json) =>
      _$AutoInvestQueueItemFromJson(json);
}
