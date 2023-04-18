// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Province welcomeFromJson(String str) => Province.fromJson(json.decode(str));

String welcomeToJson(Province data) => json.encode(data.toJson());

class Province {
  Province({
    required this.name,
    required this.code,
    required this.divisionType,
    required this.codename,
    required this.phoneCode,
    required this.districts,
  });

  String name;
  int code;
  String divisionType;
  String codename;
  int phoneCode;
  List<dynamic> districts;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        name: json["name"],
        code: json["code"],
        divisionType: json["division_type"],
        codename: json["codename"],
        phoneCode: json["phone_code"],
        districts: List<dynamic>.from(json["districts"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "division_type": divisionType,
        "codename": codename,
        "phone_code": phoneCode,
        "districts": List<dynamic>.from(districts.map((x) => x)),
      };
}
