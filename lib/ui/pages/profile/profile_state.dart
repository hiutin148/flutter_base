import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.version = 'Unknown',
  });
  final String version;

  @override
  List<Object?> get props => [
        version,
      ];

  ProfileState copyWith({
    String? version,
  }) {
    return ProfileState(
      version: version ?? this.version,
    );
  }
}
