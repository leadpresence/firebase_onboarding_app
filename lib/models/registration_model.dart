import 'package:meta/meta.dart';
import 'dart:convert';

RegistrationModel registrationModelFromMap(String str) => RegistrationModel.fromMap(json.decode(str));

String registrationModelToMap(RegistrationModel data) => json.encode(data.toMap());

class RegistrationModel {
  RegistrationModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  String id;
  String name;
  String email;
  String password;

  factory RegistrationModel.fromMap(Map<String, dynamic> json) => RegistrationModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "password": password,
  };
}