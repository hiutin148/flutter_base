import 'package:flutter_base/models/entities/api_response/headers.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse {
  ApiResponse({required this.headers, required this.results});

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);
  @JsonKey(name: 'headers')
  final Headers headers;
  @JsonKey(name: 'results')
  final List<dynamic> results;

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}
