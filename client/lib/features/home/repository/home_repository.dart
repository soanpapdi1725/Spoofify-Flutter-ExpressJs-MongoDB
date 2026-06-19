import 'dart:convert';
import 'dart:io';

import 'package:client/core/constants/server_constant.dart';
import 'package:client/features/home/model/song_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:client/core/app_failure/app_failure.dart';

part 'home_repository.g.dart';

@Riverpod(keepAlive: true)
HomeRepository homeRepository(Ref ref) {
  return HomeRepository();
}

class HomeRepository {
  Future<Either<AppFailure, String>> uploadSongFunction({
    required File selectedAudio,
    required File selectedThumbNail,
    required String songName,
    required String artistNames,
    required String hexCode,
    required String token,
  }) async {
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse("${ServerConstant.songServerApi}/upload"),
      );
      request
        ..files.addAll([
          await http.MultipartFile.fromPath("song", selectedAudio.path),
          await http.MultipartFile.fromPath(
            "thumbnail",
            selectedThumbNail.path,
          ),
        ])
        ..fields.addAll({
          "artistNames": artistNames,
          "songName": songName,
          "hexCode": hexCode,
        })
        ..headers.addAll({"Authorization": "Bearer $token"});

      final response = await request.send();
      if (response.statusCode != 200) {
        return Left(AppFailure("Error of not"));
      }
      return Right(await response.stream.bytesToString());
    } catch (error) {
      print(error);
      return Left(AppFailure("Error Catch"));
    }
  }

  Future<Either<AppFailure, List<SongModel>>> getAllSongFunction({
    required String token,
  }) async {
    try {
      final res = await http.get(
        Uri.parse("${ServerConstant.songServerApi}/All_list"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      final resFromBody = jsonDecode(res.body) as Map<String, dynamic>;
      if (res.statusCode != 200) {
        return Left(AppFailure(resFromBody["message"]));
      }
      List<SongModel> songList = [];
      for (final singleSong in resFromBody["data"]) {
        songList.add(SongModel.fromMap(singleSong));
      }
      return Right(songList);
    } catch (error) {
      return Left(AppFailure(error.toString()));
    }
  }
}
