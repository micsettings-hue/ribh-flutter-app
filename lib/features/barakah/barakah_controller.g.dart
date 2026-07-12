// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barakah_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BarakahController)
final barakahControllerProvider = BarakahControllerProvider._();

final class BarakahControllerProvider
    extends $AsyncNotifierProvider<BarakahController, BarakahData> {
  BarakahControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'barakahControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$barakahControllerHash();

  @$internal
  @override
  BarakahController create() => BarakahController();
}

String _$barakahControllerHash() => r'b87b11c88c77401caedf678ba420f586477bdeba';

abstract class _$BarakahController extends $AsyncNotifier<BarakahData> {
  FutureOr<BarakahData> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<BarakahData>, BarakahData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BarakahData>, BarakahData>,
              AsyncValue<BarakahData>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
