// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The user's holdings joined to their campaigns, ordered running, matured,
/// recovery (then open), per the Home portfolio-row spec.

@ProviderFor(PortfolioController)
final portfolioControllerProvider = PortfolioControllerProvider._();

/// The user's holdings joined to their campaigns, ordered running, matured,
/// recovery (then open), per the Home portfolio-row spec.
final class PortfolioControllerProvider
    extends
        $AsyncNotifierProvider<PortfolioController, List<PortfolioHolding>> {
  /// The user's holdings joined to their campaigns, ordered running, matured,
  /// recovery (then open), per the Home portfolio-row spec.
  PortfolioControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'portfolioControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$portfolioControllerHash();

  @$internal
  @override
  PortfolioController create() => PortfolioController();
}

String _$portfolioControllerHash() =>
    r'35701cce1b18f88333e3a642c49b40dea45fa508';

/// The user's holdings joined to their campaigns, ordered running, matured,
/// recovery (then open), per the Home portfolio-row spec.

abstract class _$PortfolioController
    extends $AsyncNotifier<List<PortfolioHolding>> {
  FutureOr<List<PortfolioHolding>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<PortfolioHolding>>, List<PortfolioHolding>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<PortfolioHolding>>,
                List<PortfolioHolding>
              >,
              AsyncValue<List<PortfolioHolding>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
