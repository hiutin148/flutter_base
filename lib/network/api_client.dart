import 'package:dio/dio.dart';
import 'package:flutter_base/models/entities/api_response/api_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  /// Track
  @GET('/tracks/')
  Future<ApiResponse> getFeaturedTracks({
    @Query('limit') int limit = 5,
    @Query('featured') bool? featured,
  });

  /// Feeds
  @GET('/feeds/')
  Future<ApiResponse> getFeedPlaylists({
    @Query('limit') int limit = 5,
    @Query('type') String type = 'playlist',
    @Query('order') String order = 'position_asc',
  });

  @POST('/logout')
  Future<dynamic> signOut(@Body() Map<String, dynamic> body);
}
