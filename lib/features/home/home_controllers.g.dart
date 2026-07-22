// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(amanahSummary)
final amanahSummaryProvider = AmanahSummaryProvider._();

final class AmanahSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<AmanahSummary>,
          AmanahSummary,
          FutureOr<AmanahSummary>
        >
    with $FutureModifier<AmanahSummary>, $FutureProvider<AmanahSummary> {
  AmanahSummaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'amanahSummaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$amanahSummaryHash();

  @$internal
  @override
  $FutureProviderElement<AmanahSummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AmanahSummary> create(Ref ref) {
    return amanahSummary(ref);
  }
}

String _$amanahSummaryHash() => r'e081f884eae8d6708d092e109d1160680f0e6667';

@ProviderFor(homeGoals)
final homeGoalsProvider = HomeGoalsProvider._();

final class HomeGoalsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Goal>>,
          List<Goal>,
          FutureOr<List<Goal>>
        >
    with $FutureModifier<List<Goal>>, $FutureProvider<List<Goal>> {
  HomeGoalsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeGoalsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeGoalsHash();

  @$internal
  @override
  $FutureProviderElement<List<Goal>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Goal>> create(Ref ref) {
    return homeGoals(ref);
  }
}

String _$homeGoalsHash() => r'1aaaf9720df19c3e94dde1635ba9a4b42cbc1b1f';

@ProviderFor(homeNews)
final homeNewsProvider = HomeNewsProvider._();

final class HomeNewsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<NewsItem>>,
          List<NewsItem>,
          FutureOr<List<NewsItem>>
        >
    with $FutureModifier<List<NewsItem>>, $FutureProvider<List<NewsItem>> {
  HomeNewsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeNewsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeNewsHash();

  @$internal
  @override
  $FutureProviderElement<List<NewsItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<NewsItem>> create(Ref ref) {
    return homeNews(ref);
  }
}

String _$homeNewsHash() => r'ab1d03a3c725950c45357a773764fd47c155d7ff';

/// The user's largest deployment in a running campaign, for the
/// where's-my-money card. Null when nothing is running.

@ProviderFor(largestLiveDeployment)
final largestLiveDeploymentProvider = LargestLiveDeploymentProvider._();

/// The user's largest deployment in a running campaign, for the
/// where's-my-money card. Null when nothing is running.

final class LargestLiveDeploymentProvider
    extends
        $FunctionalProvider<
          AsyncValue<PortfolioHolding?>,
          PortfolioHolding?,
          FutureOr<PortfolioHolding?>
        >
    with
        $FutureModifier<PortfolioHolding?>,
        $FutureProvider<PortfolioHolding?> {
  /// The user's largest deployment in a running campaign, for the
  /// where's-my-money card. Null when nothing is running.
  LargestLiveDeploymentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'largestLiveDeploymentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$largestLiveDeploymentHash();

  @$internal
  @override
  $FutureProviderElement<PortfolioHolding?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PortfolioHolding?> create(Ref ref) {
    return largestLiveDeployment(ref);
  }
}

String _$largestLiveDeploymentHash() =>
    r'e6c36606c490e50aa74fef27e689339d7b3d9d01';
