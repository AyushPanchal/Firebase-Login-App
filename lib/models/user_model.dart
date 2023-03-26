// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id, //firebase auth
    this.fullName, //signup page
    this.email, //signup page or null is phone number
    this.phoneNumber, //signup page or null if email
    this.address, //if grants location permission
    this.city, //if grants location permission
    this.state, //if grants location permission
    this.country, //if grants location permission
    this.zipCode, //if grants location permission
    this.dateOfBirth, //Other page
    this.gender, //Other page
    this.profilePicture, //Other page
    this.createdAt, //while registering
    this.updatedAt, //if profile is updated
  });

  String? id;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? address;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  DateTime? dateOfBirth;
  String? gender;
  String? profilePicture;
  DateTime? createdAt;
  dynamic updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["fullName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        zipCode: json["zipCode"],
        dateOfBirth: json["dateOfBirth"] == null
            ? null
            : DateTime.parse(json["dateOfBirth"]),
        gender: json["gender"],
        profilePicture: json["profilePicture"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "zipCode": zipCode,
        "dateOfBirth": dateOfBirth?.toIso8601String(),
        "gender": gender,
        "profilePicture": profilePicture,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt,
      };
}
