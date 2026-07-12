// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grow_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GrowController)
final growControllerProvider = GrowControllerProvider._();

final class GrowControllerProvider
    extends $AsyncNotifierProvider<GrowController, GrowData> {
  GrowControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'growControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$growControllerHash();

  @$internal
  @override
  GrowController create() => GrowController();
}

String _$growControllerHash() => r'a031b0f4a7e6950727ae38cd4545ad2a6472034f';

abstract class _$GrowController extends $AsyncNotifier<GrowData> {
  FutureOr<GrowData> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<GrowData>, GrowData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<GrowData>, GrowData>,
              AsyncValue<GrowData>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Goal mutations for Grow. Reads reuse [homeGoalsProvider] so Home and
/// Grow always show the same list. keepAlive: nothing watches this
/// mutation-only controller, and autoDispose would unmount its Ref while a
/// sheet's write is still in flight.

@ProviderFor(GoalsController)
final goalsControllerProvider = GoalsControllerProvider._();

/// Goal mutations for Grow. Reads reuse [homeGoalsProvider] so Home and
/// Grow always show the same list. keepAlive: nothing watches this
/// mutation-only controller, and autoDispose would unmount its Ref while a
/// sheet's write is still in flight.
final class GoalsControllerProvider
    extends $AsyncNotifierProvider<GoalsController, void> {
  /// Goal mutations for Grow. Reads reuse [homeGoalsProvider] so Home and
  /// Grow always show the same list. keepAlive: nothing watches this
  /// mutation-only controller, and autoDispose would unmount its Ref while a
  /// sheet's write is still in flight.
  GoalsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalsControllerHash();

  @$internal
  @override
  GoalsController create() => GoalsController();
}

String _$goalsControllerHash() => r'8ac1f87bf87c2c82c4bce55578ec757bd066cdb6';

/// Goal mutations for Grow. Reads reuse [homeGoalsProvider] so Home and
/// Grow always show the same list. keepAlive: nothing watches this
/// mutation-only controller, and autoDispose would unmount its Ref while a
/// sheet's write is still in flight.

abstract class _$GoalsController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
