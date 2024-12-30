import 'package:json_annotation/json_annotation.dart';

part 'track_entity.g.dart';

@JsonSerializable()
class TrackEntity {
  TrackEntity({
    required this.albumId,
    required this.albumImage,
    required this.albumName,
    required this.artistId,
    required this.artistIdstr,
    required this.artistName,
    required this.audio,
    required this.audiodownload,
    required this.audiodownloadAllowed,
    required this.duration,
    required this.id,
    required this.image,
    required this.licenseCcurl,
    required this.name,
    required this.position,
    required this.prourl,
    required this.releasedate,
    required this.shareurl,
    required this.shorturl,
    required this.waveform,
  });

  factory TrackEntity.fromJson(Map<String, dynamic> json) =>
      _$TrackEntityFromJson(json);
  @JsonKey(name: 'album_id')
  final String albumId;
  @JsonKey(name: 'album_image')
  final String albumImage;
  @JsonKey(name: 'album_name')
  final String albumName;
  @JsonKey(name: 'artist_id')
  final String artistId;
  @JsonKey(name: 'artist_idstr')
  final String artistIdstr;
  @JsonKey(name: 'artist_name')
  final String artistName;
  @JsonKey(name: 'audio')
  final String audio;
  @JsonKey(name: 'audiodownload')
  final String audiodownload;
  @JsonKey(name: 'audiodownload_allowed')
  final bool audiodownloadAllowed;
  @JsonKey(name: 'duration')
  final int duration;
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'image')
  final String image;
  @JsonKey(name: 'license_ccurl')
  final String licenseCcurl;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'position')
  final int position;
  @JsonKey(name: 'prourl')
  final String prourl;
  @JsonKey(name: 'releasedate')
  final String releasedate;
  @JsonKey(name: 'shareurl')
  final String shareurl;
  @JsonKey(name: 'shorturl')
  final String shorturl;
  @JsonKey(name: 'waveform')
  final String waveform;

  Map<String, dynamic> toJson() => _$TrackEntityToJson(this);
}
