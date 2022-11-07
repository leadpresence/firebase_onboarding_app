import 'dart:convert';

UserModel userModelFromMap(String str) => UserModel.fromMap(json.decode(str));

String userModelToMap(UserModel data) => json.encode(data.toMap());

class UserModel {
  UserModel({String? id,
    this.userName,
    this.email,
    this.phoneNumber,
  });

  String? id="";
  String? userName="";
  String? email="";
  String? phoneNumber="";

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    userName: json["userName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "userName": userName,
    "email": email,
    "phoneNumber": phoneNumber,
  };
}