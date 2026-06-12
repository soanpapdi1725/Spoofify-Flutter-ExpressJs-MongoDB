// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthViewmodel)
final authViewmodelProvider = AuthViewmodelProvider._();

final class AuthViewmodelProvider
    extends $NotifierProvider<AuthViewmodel, AsyncValue<UserModel>?> {
  AuthViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authViewmodelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authViewmodelHash();

  @$internal
  @override
  AuthViewmodel create() => AuthViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<UserModel>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<UserModel>?>(value),
    );
  }
}

String _$authViewmodelHash() => r'ed907918a30b24dd2df9a455977973321b6b1084';

abstract class _$AuthViewmodel extends $Notifier<AsyncValue<UserModel>?> {
  AsyncValue<UserModel>? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<UserModel>?, AsyncValue<UserModel>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserModel>?, AsyncValue<UserModel>?>,
              AsyncValue<UserModel>?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
