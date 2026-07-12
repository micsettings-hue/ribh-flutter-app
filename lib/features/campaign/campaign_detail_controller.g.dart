// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_detail_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CampaignDetailController)
final campaignDetailControllerProvider = CampaignDetailControllerFamily._();

final class CampaignDetailControllerProvider
    extends $AsyncNotifierProvider<CampaignDetailController, Campaign> {
  CampaignDetailControllerProvider._({
    required CampaignDetailControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'campaignDetailControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$campaignDetailControllerHash();

  @override
  String toString() {
    return r'campaignDetailControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CampaignDetailController create() => CampaignDetailController();

  @override
  bool operator ==(Object other) {
    return other is CampaignDetailControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$campaignDetailControllerHash() =>
    r'1d09bec00ae46455f98861a873742286958f1585';

final class CampaignDetailControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          CampaignDetailController,
          AsyncValue<Campaign>,
          Campaign,
          FutureOr<Campaign>,
          String
        > {
  CampaignDetailControllerFamily._()
    : super(
        retry: null,
        name: r'campaignDetailControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CampaignDetailControllerProvider call(String campaignId) =>
      CampaignDetailControllerProvider._(argument: campaignId, from: this);

  @override
  String toString() => r'campaignDetailControllerProvider';
}

abstract class _$CampaignDetailController extends $AsyncNotifier<Campaign> {
  late final _$args = ref.$arg as String;
  String get campaignId => _$args;

  FutureOr<Campaign> build(String campaignId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Campaign>, Campaign>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Campaign>, Campaign>,
              AsyncValue<Campaign>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
