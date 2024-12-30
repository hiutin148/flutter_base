import 'package:flutter_base/locator.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/track_repository.dart';
import 'package:flutter_base/ui/pages/home/home_navigator.dart';
import 'package:flutter_base/ui/pages/home/home_state.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_base/utils/my_audio_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.navigator,
    required this.trackRepo,
  }) : super(const HomeState());
  final HomeNavigator navigator;
  final TrackRepository trackRepo;

  Future<void> fetchInitialMovies() async {
    if (state.loadMovieStatus == LoadStatus.loading) {
      return;
    }
    emit(state.copyWith(loadMovieStatus: LoadStatus.loading));

    try {
      final response = await trackRepo.getFeaturedTracks(featured: true);
      if (response != null) {
        await sl<MyAudioHandler>().initSongs(songs: response);
        emit(
          state.copyWith(
            loadMovieStatus: LoadStatus.success,
            featuredTracks: response,
          ),
        );
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(loadMovieStatus: LoadStatus.failure));
    }
  }

  Future<void> fetchNextMovies() async {
    if (state.page == state.totalPages) {
      return;
    }
    if (state.loadMovieStatus == LoadStatus.loadingMore) {
      return;
    }
    emit(
      state.copyWith(
        loadMovieStatus: LoadStatus.loadingMore,
      ),
    );
    await Future<void>.delayed(const Duration(seconds: 1));
    try {
      emit(
        state.copyWith(
          loadMovieStatus: LoadStatus.success,
          featuredTracks: [],
        ),
      );
    } catch (e) {
      logger.i(e.toString());
    }
  }
}
