// To parse this JSON data, do
//
//     final recruitment = recruitmentFromJson(jsonString);

import 'dart:convert';

Recruitment recruitmentFromJson(String str) => Recruitment.fromJson(json.decode(str));

String recruitmentToJson(Recruitment data) => json.encode(data.toJson());

class Recruitment {
    String companyId;
    String title;
    String salary;
    DateTime deadline;
    String workingForm;
    int numberOfRecruits;
    String gender;
    String experience;
    String position;
    String address;
    String descriptionWorking;
    String request;
    String benefit;
    DateTime createdAt;
    DateTime updatedAt;
    String id;

    Recruitment({
        required this.companyId,
        required this.title,
        required this.salary,
        required this.deadline,
        required this.workingForm,
        required this.numberOfRecruits,
        required this.gender,
        required this.experience,
        required this.position,
        required this.address,
        required this.descriptionWorking,
        required this.request,
        required this.benefit,
        required this.createdAt,
        required this.updatedAt,
        required this.id,
    });

    factory Recruitment.fromJson(Map<String, dynamic> json) => Recruitment(
        companyId: json["company_id"],
        title: json["title"],
        salary: json["salary"],
        deadline: DateTime.parse(json["deadline"]),
        workingForm: json["workingForm"],
        numberOfRecruits: json["numberOfRecruits"],
        gender: json["gender"],
        experience: json["experience"],
        position: json["position"],
        address: json["address"],
        descriptionWorking: json["descriptionWorking"],
        request: json["request"],
        benefit: json["benefit"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "title": title,
        "salary": salary,
        "deadline": deadline.toIso8601String(),
        "workingForm": workingForm,
        "numberOfRecruits": numberOfRecruits,
        "gender": gender,
        "experience": experience,
        "position": position,
        "address": address,
        "descriptionWorking": descriptionWorking,
        "request": request,
        "benefit": benefit,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
    };
}
