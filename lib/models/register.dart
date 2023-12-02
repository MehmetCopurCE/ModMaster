// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  final String registerAddress;
  final String registerName;
  final String registerValue;
  final String displayName;

  Register({
    required this.registerAddress,
    required this.registerName,
    required this.registerValue,
    required this.displayName,
  });

  factory Register.fromJson(Map<String, dynamic> json) => Register(
    registerAddress: json["registerAddress"],
    registerName: json["registerName"],
    registerValue: json["registerValue"],
    displayName: json["displayName"],
  );

  Map<String, dynamic> toJson() => {
    "registerAddress": registerAddress,
    "registerName": registerName,
    "registerValue": registerValue,
    "displayName": displayName,
  };
}
