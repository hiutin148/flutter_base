import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/entities/track/track_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';

class HomeState extends Equatable {
  const HomeState({
    this.loadMovieStatus = LoadStatus.initial,
    this.featuredTracks = const [],
    this.page = 1,
    this.totalResults = 0,
    this.totalPages = 0,
  });

  final LoadStatus loadMovieStatus;
  final List<TrackEntity> featuredTracks;
  final int page;
  final int totalResults;
  final int totalPages;

  bool get hasReachedMax {
    return page >= totalPages;
  }

  @override
  List<Object?> get props => [
        loadMovieStatus,
        featuredTracks,
        page,
        totalResults,
        totalPages,
      ];

  HomeState copyWith({
    LoadStatus? loadMovieStatus,
    List<TrackEntity>? featuredTracks,
    int? page,
    int? totalResults,
    int? totalPages,
  }) {
    return HomeState(
      loadMovieStatus: loadMovieStatus ?? this.loadMovieStatus,
      featuredTracks: featuredTracks ?? this.featuredTracks,
      page: page ?? this.page,
      totalResults: totalResults ?? this.totalResults,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}
