import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_project/Storage/database_helper.dart';
import 'package:mobile_project/models/register.dart';

class DatabaseService {
  final String apiUrl =
      "https://mobileproject1211-default-rtdb.firebaseio.com/registers2.json";

  Future<void> syncData() async {
    final db = DatabaseHelper.instance;

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        // Döngü ile her bir öğeyi işle
        data.forEach((key, value) async {
          // Veriyi Register sınıfına dönüştür
          Register register = Register(
            registerName: value["registerName"],
            registerAddress: value["registerAddress"],
            registerValue: List<int>.from(value["registerValue"]),
            displayName: value["displayName"],
          );

          // Veriyi yerel veritabanına ekle
          int insertedId = await db.insertRegister(register);

          print("Inserted register with ID: $insertedId");
        });

        print("Data successfully synced to the local database");
      } else {
        // HTTP isteği başarısız olursa hata mesajını yazdır
        print("HTTP request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error when syncing data from Firebase to database: $e");
    }
  }
}
