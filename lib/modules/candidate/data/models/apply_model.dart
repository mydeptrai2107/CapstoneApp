// To parse this JSON data, do
//
//     final apply = applyFromJson(jsonString);

import 'dart:convert';

Apply applyFromJson(String str) => Apply.fromJson(json.decode(str));

String applyToJson(Apply data) => json.encode(data.toJson());

class Apply {
  String userId;
  String userProfileId;
  String recruitmentId;
  String comment;
  DateTime createdAt;
  DateTime updatedAt;
  String id;
  int statusApply;
  Apply({
    required this.userId,
    required this.userProfileId,
    required this.recruitmentId,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.statusApply,
  });

  factory Apply.fromJson(Map<String, dynamic> json) => Apply(
        userId: json["user_id"],
        userProfileId: json["user_profile_id"],
        recruitmentId: json["recruitment_id"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        statusApply: json["status_apply"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_profile_id": userProfileId,
        "recruitment_id": recruitmentId,
        "comment": comment,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "status_apply": statusApply,
      };
}
