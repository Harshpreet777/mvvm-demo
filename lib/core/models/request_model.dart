import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'request_model.g.dart';

RequestModel requestModelFromJson(String str) =>
    RequestModel.fromJson(json.decode(str));

String requestModelToJson(RequestModel data) => json.encode(data.toJson());

@JsonSerializable()
class RequestModel {
  String email;
  String name;
  String gender;
  String status;

  RequestModel({
    required this.email,
    required this.name,
    required this.gender,
    required this.status,
  });
  factory RequestModel.fromJson(Map<String, dynamic> json) =>
      _$RequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$RequestModelToJson(this);
}
