import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/register.dart';

class RegistersPage extends StatefulWidget {
  const RegistersPage({super.key});

  @override
  State<RegistersPage> createState() => _RegistersPageState();
}

class _RegistersPageState extends State<RegistersPage> {
  List<Register> registers = [];

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://mobileproject1211-default-rtdb.firebaseio.com/registers.json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);

      List<Register> tempRegisters = [];

      jsonData.forEach((key, value) {
        List<dynamic> jsonList = value;
        for (var json in jsonList) {
          tempRegisters.add(Register.fromJson(json));
        }
      });

      setState(() {
        registers = tempRegisters;
      });
    } else {
      throw Exception('Veri çekme hatası: ${response.reasonPhrase}');
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register List'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: registers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(registers[index].registerName ?? ''),
            //subtitle: Text(registers[index].registerValue ?? ''),
            trailing: Text(
              registers[index].registerValue ?? '',
              style: TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
