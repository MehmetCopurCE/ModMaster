// import 'dart:io';
// import 'package:mobile_project/models/register.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   static Database? _database;
//   static final DatabaseHelper instance = DatabaseHelper._();

//   DatabaseHelper._();

//   Future<Database?> get database async {
//     if (_database != null) {
//       return _database;
//     }

//     _database = await initDatabase();
//     return _database;
//   }

//   Future<Database> initDatabase() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, "registers.db");

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//     );
//   }

//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute('''
//           CREATE TABLE registers(
//             id TEXT PRIMARY KEY,
//             registerAddress TEXT,
//             registerName TEXT,
//             registerValue TEXT,
//             displayName TEXT
//           )
//         ''');
//   }

//   // Future<int> insertRegister(Register register) async {
//   //   try {
//   //     final db = await database;
//   //     return await db!.insert('registers', register.toJson());
//   //   } catch (e) {
//   //     print("Error when inserting registers to database: $e");
//   //     return -1;
//   //   }
//   // }

//   Future<int> insertRegister(Register register) async {
//     try {
//       final db = await database;

//       // Aynı registerAddress'e sahip kaydı kontrol et
//       List<Map<String, dynamic>> existingRecords = await db!.query(
//         'registers',
//         where: 'registerAddress = ?',
//         whereArgs: [register.registerAddress],
//       );

//       if (existingRecords.isNotEmpty) {
//         // Eğer varsa, mevcut kaydı güncelle
//         return await updateRegister(register);
//       } else {
//         // Yoksa yeni kaydı ekle
//         return await db.insert('registers', register.toJson());
//       }
//     } catch (e) {
//       print("Error when inserting registers to database: $e");
//       return -1;
//     }
//   }

//   Future<List<Register>> getAllRegisters() async {
//     try {
//       final db = await database;
//       List<Map<String, dynamic>> result = await db!.query('registers');
//       return result.map((map) => Register.fromJson(map)).toList();
//     } catch (e) {
//       print("Error when getting all registers from database: $e");
//       return [];
//     }
//   }

//   Future<Register?> getRegisterById(String id) async {
//     try {
//       final db = await database;
//       List<Map<String, dynamic>> result = await db!.query(
//         'registers',
//         where: 'id = ?',
//         whereArgs: [id],
//       );
//       if (result.isNotEmpty) {
//         return Register.fromJson(result.first);
//       } else {
//         return null;
//       }
//     } catch (e) {
//       print("Error when getting register by ID from database: $e");
//       return null;
//     }
//   }

//   Future<int> updateRegister(Register register) async {
//     try {
//       final db = await database;
//       return await db!.update(
//         'registers',
//         register.toJson(),
//         where: 'registerAddress = ?',
//         whereArgs: [register.registerAddress],
//       );
//     } catch (e) {
//       print("Error when updating register in database: $e");
//       return -1;
//     }
//   }

//   Future<int> deleteRegister(Register register) async {
//     try {
//       final db = await database;
//       return await db!.delete(
//         'registers',
//         where: 'registerAddress = ?',
//         whereArgs: [register.registerAddress],
//       );
//     } catch (e) {
//       print("Error when deleting register from database: $e");
//       return -1;
//     }
//   }
// }
