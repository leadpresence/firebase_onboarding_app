// To parse this JSON data, do
//
//     final userModel = userModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserModel userModelFromMap(String str) => UserModel.fromMap(json.decode(str));

String userModelToMap(UserModel data) => json.encode(data.toMap());

class UserModel {
  UserModel({
   this.id,
   this.firstName,
   this.lastName,
   this.email,
   this.imageUrl,
  });

  String? id="";
  String? firstName="";
  String? lastName="";
  String? email="";
  String? imageUrl="";

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "imageUrl": imageUrl,
  };
}
