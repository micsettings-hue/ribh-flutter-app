// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WalletController)
final walletControllerProvider = WalletControllerProvider._();

final class WalletControllerProvider
    extends $AsyncNotifierProvider<WalletController, WalletData> {
  WalletControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'walletControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$walletControllerHash();

  @$internal
  @override
  WalletController create() => WalletController();
}

String _$walletControllerHash() => r'dd5222fdef59304b7b6b8d03884e10d0a451e511';

abstract class _$WalletController extends $AsyncNotifier<WalletData> {
  FutureOr<WalletData> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<WalletData>, WalletData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<WalletData>, WalletData>,
              AsyncValue<WalletData>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
