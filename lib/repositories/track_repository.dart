import 'package:flutter_base/models/entities/api_response/api_response.dart';
import 'package:flutter_base/network/api_client.dart';

abstract class TrackRepository {
  Future<ApiResponse?> getFeaturedTracks({
    int? limit,
    bool? featured,
  });
}

class TrackRepositoryImpl extends TrackRepository {
  TrackRepositoryImpl({required this.apiClient});

  ApiClient apiClient;

  @override
  Future<ApiResponse?> getFeaturedTracks({
    int? limit,
    bool? featured,
  }) async {
    return apiClient.getFeaturedTracks(
      limit: limit ?? 5,
      featured: featured,
    );
  }
}
