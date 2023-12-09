import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/register.dart';

class DatabaseService {
  final String apiUrl =
      "https://mobileproject1211-default-rtdb.firebaseio.com/registers.json";
  final String databaseUrl = "";

  Future<void> syncData() async {
    Database db = await _getDatabase();

    // Belirli bir HTTP URL'inden verileri çek
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // HTTP response başarılı ise verileri al
      Map<String, dynamic> data = json.decode(response.body);

      // Alınan verileri SQLite veritabanına kaydet
      data.forEach((key, value) {
        if (value is List) {
          for (var item in value) {
            Register register = Register(
              registerAddress: item['registerAddress'],
              registerName: item['registerName'],
              registerValue: item['registerValue'],
              displayName: item['displayName'],
            );

            _insertRegister(db, register);
          }
        }
      });
      print("Başarılı bir şekilde db ye eklendi");
    } else {
      // HTTP request başarısız olduysa, hata mesajını yazdırabilirsiniz.
      print("HTTP request failed with status: ${response.statusCode}");
    }
  }

  Future<Database> _getDatabase() async {
    String path = join(await getDatabasesPath(), 'your_database_name.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE registers(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            registerAddress TEXT,
            registerName TEXT,
            registerValue TEXT,
            displayName TEXT
          )
        ''');
      },
    );
  }

  Future<int> _insertRegister(Database db, Register register) async {
    // Veritabanında aynı registerAddress'e sahip kayıt var mı kontrol et
    List<Map<String, dynamic>> existingRecords = await db.query(
      'registers',
      where: 'registerAddress = ?',
      whereArgs: [register.registerAddress],
    );

    if (existingRecords.isEmpty) {
      // Eğer kayıt yoksa ekleyin
      return await db.insert('registers', register.toJson());
    } else {
      // Eğer kayıt varsa burada gerekirse bir işlem yapabilirsiniz
      print('Kayıt zaten mevcut: ${register.registerAddress}');
      return -1; // veya başka bir değer döndürebilirsiniz
    }
  }
}
