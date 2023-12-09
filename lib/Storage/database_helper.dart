import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/register.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
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

  Future<int> insertRegister(Register register) async {
    Database db = await database;
    return await db.insert('registers', register.toJson());
  }

  Future<List<Register>> getAllRegisters() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('registers');
    return List.generate(maps.length, (i) {
      return Register(
        registerAddress: maps[i]['registerAddress'],
        registerName: maps[i]['registerName'],
        registerValue: maps[i]['registerValue'],
        displayName: maps[i]['displayName'],
      );
    });
  }
}
