// To parse this JSON data, do
//
//     final apply = applyFromJson(jsonString);

import 'dart:convert';

Apply applyFromJson(String str) => Apply.fromJson(json.decode(str));

String applyToJson(Apply data) => json.encode(data.toJson());

class Apply {
    String userProfileId;
    String recruitmentId;
    String comment;
    DateTime createdAt;
    DateTime updatedAt;
    String id;

    Apply({
        required this.userProfileId,
        required this.recruitmentId,
        required this.comment,
        required this.createdAt,
        required this.updatedAt,
        required this.id,
    });

    factory Apply.fromJson(Map<String, dynamic> json) => Apply(
        userProfileId: json["user_profile_id"],
        recruitmentId: json["recruitment_id"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "user_profile_id": userProfileId,
        "recruitment_id": recruitmentId,
        "comment": comment,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
    };
}
