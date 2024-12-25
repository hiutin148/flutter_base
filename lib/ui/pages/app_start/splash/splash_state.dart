import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/enums/load_status.dart';

class SplashState extends Equatable {
  const SplashState({
    this.fetchProfileStatus = LoadStatus.initial,
  });
  final LoadStatus fetchProfileStatus;

  SplashState copyWith({
    LoadStatus? fetchProfileStatus,
  }) {
    return SplashState(
      fetchProfileStatus: fetchProfileStatus ?? this.fetchProfileStatus,
    );
  }

  @override
  List<Object?> get props => [
        fetchProfileStatus,
      ];
}
