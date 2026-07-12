// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marketplace_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MarketplaceController)
final marketplaceControllerProvider = MarketplaceControllerProvider._();

final class MarketplaceControllerProvider
    extends $AsyncNotifierProvider<MarketplaceController, MarketplaceData> {
  MarketplaceControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'marketplaceControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$marketplaceControllerHash();

  @$internal
  @override
  MarketplaceController create() => MarketplaceController();
}

String _$marketplaceControllerHash() =>
    r'f9568f9d07763b14bad5bdc4b17e440cebed734c';

abstract class _$MarketplaceController extends $AsyncNotifier<MarketplaceData> {
  FutureOr<MarketplaceData> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<MarketplaceData>, MarketplaceData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<MarketplaceData>, MarketplaceData>,
              AsyncValue<MarketplaceData>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
