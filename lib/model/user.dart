// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.name,
    this.designation,
    this.username,
    this.password,
  });

  int? id;
  String? name;
  String? designation;
  String? username;
  String? password;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["Id"],
        name: json["Name"],
        designation: json["Designation"],
        username: json["Username"],
        password: json["Password"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Designation": designation,
        "Username": username,
        "Password": password,
      };
}
