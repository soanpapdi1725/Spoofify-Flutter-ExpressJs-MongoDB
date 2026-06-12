// ignore_for_file: non_constant_identifier_names, public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:client/features/auth/model/user_model.dart';

class SongModel {
  final String id;
  final String songName;
  final String artistNames;
  final String hexCode;
  final String thumbnail_url;
  final String song_url;
  final UserModel createdBy;
  SongModel({
    required this.id,
    required this.songName,
    required this.artistNames,
    required this.hexCode,
    required this.thumbnail_url,
    required this.song_url,
    required this.createdBy,
  });

  SongModel copyWith({
    String? id,
    String? songName,
    String? artistNames,
    String? hexCode,
    String? thumbnail_url,
    String? song_url,
    UserModel? createdBy,
  }) {
    return SongModel(
      id: id ?? this.id,
      songName: songName ?? this.songName,
      artistNames: artistNames ?? this.artistNames,
      hexCode: hexCode ?? this.hexCode,
      thumbnail_url: thumbnail_url ?? this.thumbnail_url,
      song_url: song_url ?? this.song_url,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'songName': songName,
      'artistNames': artistNames,
      'hexCode': hexCode,
      'thumbnail_url': thumbnail_url,
      'song_url': song_url,
      'createdBy': createdBy.toMap(),
    };
  }

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      id: map['id'] ?? "",
      songName: map['songName'] ?? "",
      artistNames: map['artistNames'] ?? "",
      hexCode: map['hexCode'] ?? "",
      thumbnail_url: map['thumbnail_url'] ?? "",
      song_url: map['song_url'] ?? "",
      createdBy: UserModel.fromMap(
        map['createdBy'] ??
            {"id": "", "firstName": "", "lastName": "", "email": ""},
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SongModel.fromJson(String source) =>
      SongModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SongModel(id: $id, songName: $songName, artistNames: $artistNames, hexCode: $hexCode, thumbnail_url: $thumbnail_url, song_url: $song_url, createdBy: $createdBy)';
  }

  @override
  bool operator ==(covariant SongModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.songName == songName &&
        other.artistNames == artistNames &&
        other.hexCode == hexCode &&
        other.thumbnail_url == thumbnail_url &&
        other.song_url == song_url &&
        other.createdBy == createdBy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        songName.hashCode ^
        artistNames.hashCode ^
        hexCode.hashCode ^
        thumbnail_url.hashCode ^
        song_url.hashCode ^
        createdBy.hashCode;
  }
}
