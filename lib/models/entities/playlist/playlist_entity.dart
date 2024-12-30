import 'package:flutter_base/models/entities/playlist/playlist_track_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'playlist_entity.g.dart';

@JsonSerializable()
class PlaylistEntity {
  PlaylistEntity({
    required this.id,
    required this.name,
    required this.creationdate,
    required this.userId,
    required this.userName,
    required this.zip,
    required this.tracks,
  });

  factory PlaylistEntity.fromJson(Map<String, dynamic> json) =>
      _$PlaylistEntityFromJson(json);
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'creationdate')
  DateTime creationdate;
  @JsonKey(name: 'user_id')
  String userId;
  @JsonKey(name: 'user_name')
  String userName;
  @JsonKey(name: 'zip')
  String zip;
  @JsonKey(name: 'tracks')
  List<PlaylistTrackEntity> tracks;

  Map<String, dynamic> toJson() => _$PlaylistEntityToJson(this);
}
