import 'package:audio_service/audio_service.dart';
import 'package:flutter_base/models/entities/track/track_entity.dart';
import 'package:flutter_base/network/api_client.dart';

abstract class PlaylistRepository {
  Future<List<MediaItem>?> getFeaturedTracks({
    int? limit,
    bool? featured,
  });
}

class PlaylistRepositoryImpl extends PlaylistRepository {
  PlaylistRepositoryImpl({required this.apiClient});

  ApiClient apiClient;

  @override
  Future<List<MediaItem>?> getFeaturedTracks({
    int? limit,
    bool? featured,
  }) async {
    final response = await apiClient.getFeaturedTracks(
      limit: limit ?? 5,
      featured: featured,
    );
    final tracks = response.results
        .map(
          (e) => TrackEntity.fromJson(e as Map<String, dynamic>),
        )
        .toList();
    return tracks
        .map(
          (e) => MediaItem(
            id: e.audio,
            title: e.name,
            artist: e.artistName,
            duration: Duration(seconds: e.duration),
            artUri: Uri.parse(e.image),
          ),
        )
        .toList();
  }
}
