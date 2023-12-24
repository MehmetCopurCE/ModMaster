// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  final String registerName;
  final String registerAddress;
  final List<RegisterValue> registerValue;
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
        registerValue: List<RegisterValue>.from(
            json["registerValue"].map((x) => RegisterValue.fromJson(x))),
        displayName: json["displayName"],
      );

  Map<String, dynamic> toJson() => {
        "registerName": registerName,
        "registerAddress": registerAddress,
        "registerValue":
            List<dynamic>.from(registerValue.map((x) => x.toJson())),
        "displayName": displayName,
      };
}

// class RegisterValue {
//   final DateTime date;
//   final String value;

//   RegisterValue({
//     required this.date,
//     required this.value,
//   });

//   // factory RegisterValue.fromJson(Map<String, dynamic> json) => RegisterValue(
//   //       date: (json['date'] as Timestamp)
//   //           .toDate(), // Convert Timestamp to DateTime
//   //       value: json["value"],
//   //     );

//   // factory RegisterValue.fromJson(Map<String, dynamic> json) {
//   //   return RegisterValue(
//   //     //date: DateTime.parse(json["date"]),
//   //     date:
//   //         (json['date'] as Timestamp).toDate(), // Convert Timestamp to DateTime
//   //     value: json["value"].toString(), // Convert to String
//   //   );
//   // }

//   factory RegisterValue.fromJson(Map<String, dynamic> json) {
//     return RegisterValue(
//       date: DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSS').parse(json["date"]),
//       value: json["value"].toString(),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "date": date.toIso8601String(),
//         "value": value,
//       };
// }

class RegisterValue {
  final DateTime date;
  final String value;

  RegisterValue({
    required this.date,
    required this.value,
  });

  factory RegisterValue.fromJson(Map<String, dynamic> json) {
    return RegisterValue(
      date: (json['date'] as Timestamp).toDate(),
      value: json['value'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "date": date, // Assuming date is a DateTime object
        "value": value,
      };
}
