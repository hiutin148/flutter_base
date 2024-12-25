part of 'app_setting_cubit.dart';

class AppSettingState extends Equatable {
  const AppSettingState({
    this.language = AppConfigs.defaultLanguage,
  });
  final Language language;

  @override
  List<Object?> get props => [
        language,
      ];

  AppSettingState copyWith({
    Language? language,
  }) {
    return AppSettingState(
      language: language ?? this.language,
    );
  }
}
