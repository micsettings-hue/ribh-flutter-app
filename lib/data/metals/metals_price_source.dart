import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/failures/failure.dart';
import '../../core/result/result.dart';

/// A live silver price for the Nisab threshold (silver standard).
class SilverPrice {
  const SilverPrice({required this.perGramPoisha, required this.asOf});

  final int perGramPoisha;
  final DateTime asOf;
}

/// Source of the metals price behind the Nisab status. A real
/// implementation calls a metals price API with credentials injected at
/// build time, never committed.
abstract class MetalsPriceSource {
  Future<Result<SilverPrice>> silverPrice();
}

/// The honest v1 source: no price API is connected, so the Nisab status is
/// shown as unavailable rather than computed from an invented number.
class UnconnectedMetalsPriceSource implements MetalsPriceSource {
  const UnconnectedMetalsPriceSource();

  @override
  Future<Result<SilverPrice>> silverPrice() async =>
      const Err(DataSourceUnavailableFailure());
}

final metalsPriceSourceProvider = Provider<MetalsPriceSource>(
  (ref) => const UnconnectedMetalsPriceSource(),
);
