import 'dart:io';

import 'package:client/core/constants/server_constant.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(Ref ref) {
  return HomeRepository();
}

class HomeRepository {
  Future<Either<Failure, String>> uploadSongFunction({
    required File selectedAudio,
    required File selectedThumbNail,
    required String songName,
    required String artistNames,
    required String hexCode,
    required String token,
  }) async {
    final String songUrl =
        "http://${ServerConstant.serverUrl}:4000/api/v1/song";
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse("$songUrl/upload"),
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
      if (response != 200) {
        return Left(Failure("Error of not"));
      }
      print(await response.stream.bytesToString());
      return Right(await response.stream.bytesToString());
    } catch (error) {
      print(error);
      return Left(Failure("Error Catch"));
    }
  }
}
