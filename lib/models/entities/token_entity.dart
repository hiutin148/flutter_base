import 'package:json_annotation/json_annotation.dart';

part 'token_entity.g.dart';

@JsonSerializable()
class TokenEntity {
  TokenEntity({
    this.accessToken = '',
    this.refreshToken = '',
  });

  factory TokenEntity.fromJson(Map<String, dynamic> json) =>
      _$TokenEntityFromJson(json);
  @JsonKey()
  String accessToken;
  @JsonKey()
  String refreshToken;

  Map<String, dynamic> toJson() => _$TokenEntityToJson(this);
}
