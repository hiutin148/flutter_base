import 'package:json_annotation/json_annotation.dart';

part 'playlist_track_entity.g.dart';

@JsonSerializable()
class PlaylistTrackEntity {
  PlaylistTrackEntity({
    required this.id,
    required this.name,
    required this.albumId,
    required this.artistId,
    required this.duration,
    required this.artistName,
    required this.playlistadddate,
    required this.position,
    required this.licenseCcurl,
    required this.albumImage,
    required this.image,
    required this.audio,
    required this.audiodownload,
    required this.audiodownloadAllowed,
  });

  factory PlaylistTrackEntity.fromJson(Map<String, dynamic> json) =>
      _$PlaylistTrackEntityFromJson(json);
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'album_id')
  String albumId;
  @JsonKey(name: 'artist_id')
  String artistId;
  @JsonKey(name: 'duration')
  String duration;
  @JsonKey(name: 'artist_name')
  String artistName;
  @JsonKey(name: 'playlistadddate')
  DateTime playlistadddate;
  @JsonKey(name: 'position')
  String position;
  @JsonKey(name: 'license_ccurl')
  String licenseCcurl;
  @JsonKey(name: 'album_image')
  String albumImage;
  @JsonKey(name: 'image')
  String image;
  @JsonKey(name: 'audio')
  String audio;
  @JsonKey(name: 'audiodownload')
  String audiodownload;
  @JsonKey(name: 'audiodownload_allowed')
  bool audiodownloadAllowed;

  Map<String, dynamic> toJson() => _$PlaylistTrackEntityToJson(this);
}
