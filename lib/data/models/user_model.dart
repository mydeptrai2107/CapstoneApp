// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String firstName;
    String lastName;
    DateTime? createdAt;
    DateTime? updatedAt;
    String phone;
    String id;
    String avatar;

    User({
        required this.firstName,
        required this.lastName,
        this.createdAt,
        this.updatedAt,
        required this.phone,
        required this.id,
        required this.avatar,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["first_name"],
        lastName: json["last_name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        phone: json["phone"],
        id: json["id"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "phone": phone,
        "id": id,
        "avatar": avatar,
    };
}
