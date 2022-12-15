// To parse this JSON data, do
//
//     final household = householdFromJson(jsonString);

import 'dart:convert';

List<Household> householdFromJson(String str) =>
    List<Household>.from(json.decode(str).map((x) => Household.fromJson(x)));

String householdToJson(List<Household> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Household {
  Household({
    this.id,
    this.latitude,
    this.longitude,
    this.residenceName,
    this.headofFamily,
    this.address,
  });

  int? id;
  dynamic latitude;
  dynamic longitude;
  String? residenceName;
  String? headofFamily;
  String? address;

  factory Household.fromJson(Map<String, dynamic> json) => Household(
        id: json["Id"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        residenceName:
            json["ResidenceName"] == null ? null : json["ResidenceName"],
        headofFamily:
            json["HeadofFamily"] == null ? null : json["HeadofFamily"],
        address: json["Address"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Latitude": latitude,
        "Longitude": longitude,
        "ResidenceName": residenceName == null ? null : residenceName,
        "HeadofFamily": headofFamily == null ? null : headofFamily,
        "Address": address,
      };
}
