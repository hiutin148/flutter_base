import 'package:json_annotation/json_annotation.dart';

part 'headers.g.dart';

@JsonSerializable()
class Headers {
  Headers({
    required this.code,
    required this.errorMessage,
    required this.next,
    required this.resultsCount,
    required this.status,
    required this.warnings,
  });

  factory Headers.fromJson(Map<String, dynamic> json) =>
      _$HeadersFromJson(json);
  @JsonKey(name: 'code')
  final int code;
  @JsonKey(name: 'error_message')
  final String errorMessage;
  @JsonKey(name: 'next')
  final String next;
  @JsonKey(name: 'results_count')
  final int resultsCount;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'warnings')
  final String warnings;

  Map<String, dynamic> toJson() => _$HeadersToJson(this);
}
