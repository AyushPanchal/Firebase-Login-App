import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

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
    this.profilePictureURL, //Other page
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
  String? profilePictureURL;
  DateTime? createdAt;
  DateTime? updatedAt;

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
            : (json["dateOfBirth"] as Timestamp).toDate(),
        gender: json["gender"],
        profilePictureURL: json["profilePictureURL"],
        createdAt: json["createdAt"] == null
            ? null
            : (json["createdAt"] as Timestamp).toDate(),
        updatedAt: json["updatedAt"] == null
            ? null
            : (json["updatedAt"] as Timestamp).toDate(),
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
        "dateOfBirth": dateOfBirth,
        "gender": gender,
        "profilePictureURL": profilePictureURL,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
