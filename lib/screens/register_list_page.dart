import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/register.dart';

class RegisterListPage extends StatefulWidget {
  @override
  _RegisterListPageState createState() => _RegisterListPageState();
}

class _RegisterListPageState extends State<RegisterListPage> {
  List<Register> registers = [];

  @override
  void initState() {
    super.initState();
    _loadRegisters();
  }

  Future<void> _loadRegisters() async {
    Database db = await _getDatabase();
    List<Register> loadedRegisters = await _getAllRegisters(db);

    setState(() {
      registers = loadedRegisters;
    });
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

  Future<List<Register>> _getAllRegisters(Database db) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register List'),
      ),
      body: _buildRegisterList(),
    );
  }

  Widget _buildRegisterList() {
    if (registers.isEmpty) {
      return Center(
        child: Text('No registers available.'),
      );
    }

    return ListView.builder(
      itemCount: registers.length,
      itemBuilder: (context, index) {
        Register register = registers[index];
        return ListTile(
          title: Text('Name: ${register.registerName}'),
          subtitle: Text('Address: ${register.registerAddress}'),
          // Diğer bilgileri de buraya ekleyebilirsiniz.
        );
      },
    );
  }
}
