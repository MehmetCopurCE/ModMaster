import 'package:flutter/material.dart';
import 'package:mobile_project/Storage/database_helper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/register.dart';

class RegisterListPage extends StatefulWidget {
  @override
  _RegisterListPageState createState() => _RegisterListPageState();
}

class _RegisterListPageState extends State<RegisterListPage> {
  List<Register> registers = [];
  DatabaseHelper db = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<Register> fetchedRegisters = await db.getAllRegisters();
    setState(() {
      registers = fetchedRegisters;
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
