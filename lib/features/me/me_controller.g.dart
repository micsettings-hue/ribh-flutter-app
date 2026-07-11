// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'me_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MeController)
final meControllerProvider = MeControllerProvider._();

final class MeControllerProvider
    extends $AsyncNotifierProvider<MeController, MeData> {
  MeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'meControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$meControllerHash();

  @$internal
  @override
  MeController create() => MeController();
}

String _$meControllerHash() => r'743b7b4c46a4a2f6b7560274cb79a38f1e47cd70';

abstract class _$MeController extends $AsyncNotifier<MeData> {
  FutureOr<MeData> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<MeData>, MeData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<MeData>, MeData>,
              AsyncValue<MeData>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
