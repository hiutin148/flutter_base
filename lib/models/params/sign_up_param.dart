import 'package:json_annotation/json_annotation.dart';

part 'sign_up_param.g.dart';

@JsonSerializable()
class SignUpParam {
  SignUpParam({
    this.email,
    this.name,
    this.password,
    this.phone,
  });

  factory SignUpParam.fromJson(Map<String, dynamic> json) =>
      _$SignUpParamFromJson(json);
  @JsonKey()
  final String? email;
  @JsonKey()
  final String? name;
  @JsonKey()
  final String? password;
  @JsonKey()
  final String? phone;

  Map<String, dynamic> toJson() => _$SignUpParamToJson(this);
}
