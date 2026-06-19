// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_song_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentSongNotifier)
final currentSongProvider = CurrentSongNotifierProvider._();

final class CurrentSongNotifierProvider
    extends
        $NotifierProvider<
          CurrentSongNotifier,
          ({bool isPlaying, SongModel? song})
        > {
  CurrentSongNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentSongProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentSongNotifierHash();

  @$internal
  @override
  CurrentSongNotifier create() => CurrentSongNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(({bool isPlaying, SongModel? song}) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<({bool isPlaying, SongModel? song})>(
        value,
      ),
    );
  }
}

String _$currentSongNotifierHash() =>
    r'57279a9f0611c8656d65404106ef98046be5b015';

abstract class _$CurrentSongNotifier
    extends $Notifier<({bool isPlaying, SongModel? song})> {
  ({bool isPlaying, SongModel? song}) build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              ({bool isPlaying, SongModel? song}),
              ({bool isPlaying, SongModel? song})
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                ({bool isPlaying, SongModel? song}),
                ({bool isPlaying, SongModel? song})
              >,
              ({bool isPlaying, SongModel? song}),
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
