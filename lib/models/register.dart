// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  final String registerName;
  final String registerAddress;
  final List<int> registerValue;
  final String displayName;

  Register({
    required this.registerName,
    required this.registerAddress,
    required this.registerValue,
    required this.displayName,
  });

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        registerName: json["registerName"],
        registerAddress: json["registerAddress"],
        registerValue: List<int>.from(json["registerValue"].map((x) => x)),
        displayName: json["displayName"],
      );

  Map<String, dynamic> toJson() => {
        "registerName": registerName,
        "registerAddress": registerAddress,
        "registerValue": List<dynamic>.from(registerValue.map((x) => x)),
        "displayName": displayName,
      };
}
