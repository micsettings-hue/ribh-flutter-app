// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PrayerController)
final prayerControllerProvider = PrayerControllerProvider._();

final class PrayerControllerProvider
    extends $AsyncNotifierProvider<PrayerController, PrayerData> {
  PrayerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prayerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prayerControllerHash();

  @$internal
  @override
  PrayerController create() => PrayerController();
}

String _$prayerControllerHash() => r'990d0f95fe314a5e565f8fa1ad37508b056ae894';

abstract class _$PrayerController extends $AsyncNotifier<PrayerData> {
  FutureOr<PrayerData> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PrayerData>, PrayerData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PrayerData>, PrayerData>,
              AsyncValue<PrayerData>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
