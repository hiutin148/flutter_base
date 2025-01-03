import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'photo_view_state.dart';

class PhotoViewCubit extends Cubit<DetailMoviePhotoViewState> {
  PhotoViewCubit() : super(const DetailMoviePhotoViewState());
}
