import 'dart:io';

import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/utils.dart';
import 'package:client/features/home/model/song_model.dart';
import 'package:client/features/home/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

@riverpod
Future<List<SongModel>> getAllSongs(Ref ref) async {
  final token = ref.watch(currentUserProvider)!.token!;
  final res = await ref
      .watch(homeRepositoryProvider)
      .getAllSongFunction(token: token);
  return switch (res) {
    Left(value: final l) => throw l.error,
    Right(value: final r) => r,
  };
}

@Riverpod(keepAlive: true)
class HomeViewModel extends _$HomeViewModel {
  late HomeRepository _homeRepository;
  @override
  AsyncValue? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    return null;
  }

  Future<void> uploadSong({
    required File selectedAudio,
    required File selectedThumbNail,
    required String songName,
    required String artistNames,
    required Color hexCode,
  }) async {
    state = const AsyncValue.loading();

    final res = await _homeRepository.uploadSongFunction(
      songName: songName,
      artistNames: artistNames,
      hexCode: rgbToHex(hexCode),
      selectedAudio: selectedAudio,
      selectedThumbNail: selectedThumbNail,
      token: ref.read(currentUserProvider)!.token!,
    );
    final val = switch (res) {
      Left(value: final l) => state = AsyncValue.error(
        l.error,
        StackTrace.current,
      ),
      Right(value: final r) => state = AsyncValue.data(r),
    };

    print(val);
  }
}
