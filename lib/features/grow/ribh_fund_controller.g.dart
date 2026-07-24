// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ribh_fund_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Reuses [portfolioControllerProvider], so the fund view reflects the same
/// holdings as Home and reloads whenever money moves.

@ProviderFor(ribhFundSummary)
final ribhFundSummaryProvider = RibhFundSummaryProvider._();

/// Reuses [portfolioControllerProvider], so the fund view reflects the same
/// holdings as Home and reloads whenever money moves.

final class RibhFundSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<RibhFundSummary>,
          RibhFundSummary,
          FutureOr<RibhFundSummary>
        >
    with $FutureModifier<RibhFundSummary>, $FutureProvider<RibhFundSummary> {
  /// Reuses [portfolioControllerProvider], so the fund view reflects the same
  /// holdings as Home and reloads whenever money moves.
  RibhFundSummaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ribhFundSummaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ribhFundSummaryHash();

  @$internal
  @override
  $FutureProviderElement<RibhFundSummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<RibhFundSummary> create(Ref ref) {
    return ribhFundSummary(ref);
  }
}

String _$ribhFundSummaryHash() => r'a34d61452ac6fd27a226dfb434008ab53821b00e';
