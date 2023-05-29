// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String userId;
  String accountId;
  String email;
  String firstName;
  String lastName;
  String? phone;
  String? gender;
  String? avatar;

  User({
    required this.userId,
    required this.accountId,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.gender,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        accountId: json["accountId"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"] ?? '',
        gender: json["gender"] ?? '',
        avatar: json["avatar"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "accountId": accountId,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "gender": gender,
        "avatar": avatar,
      };
}
