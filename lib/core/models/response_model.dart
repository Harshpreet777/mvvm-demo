import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'response_model.g.dart';

List<ResponseModel> responseModelFromJson(String str) =>
    List<ResponseModel>.from(
        json.decode(str).map((x) => ResponseModel.fromJson(x)));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

@JsonSerializable()
class ResponseModel {
  int id;
  String name;
  String email;
  String gender;
  String? status;

  ResponseModel({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
     this.status,
     
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}

// enum Gender { female, male }

// final genderValues = EnumValues({"female": Gender.female, "male": Gender.male});

// enum Status { active, inactive }

// final statusValues =
//     EnumValues({"active": Status.active, "inactive": Status.inactive});

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
