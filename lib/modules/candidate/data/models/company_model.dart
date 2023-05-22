// To parse this JSON data, do
//
//     final company = companyFromJson(jsonString);

import 'dart:convert';

Company companyFromJson(String str) => Company.fromJson(json.decode(str));

String companyToJson(Company data) => json.encode(data.toJson());

class Company {
  String name;
  String contact;
  DateTime createdAt;
  DateTime updatedAt;
  String? avatar;
  String? info;
  String? type;
  String? address;
  String id;

  Company({
    required this.name,
    required this.contact,
    required this.createdAt,
    required this.updatedAt,
    this.avatar,
    this.info,
    this.type,
    this.address,
    required this.id,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        name: json["name"],
        contact: json["contact"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        avatar: json["avatar"] ?? '',
        info: json["info"] ?? '',
        type: json["type"] ?? '',
        address: json["address"] ?? '',
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "contact": contact,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "avatar": avatar,
        "info": info,
        "type": type,
        "address": address,
        "id": id,
      };
}
