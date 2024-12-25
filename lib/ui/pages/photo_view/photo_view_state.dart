part of 'photo_view_cubit.dart';

class DetailMoviePhotoViewState extends Equatable {
  const DetailMoviePhotoViewState({
    this.loadDataStatus = LoadStatus.initial,
  });
  final LoadStatus loadDataStatus;

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  DetailMoviePhotoViewState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return DetailMoviePhotoViewState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
