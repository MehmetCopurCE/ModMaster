import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mobile_project/auth/widgets/login_form.dart';
import 'package:mobile_project/models/register.dart';
import 'package:mobile_project/screens/user_screens/register_detail_page.dart';
import 'package:mobile_project/service/firestore_service.dart';
import 'package:mobile_project/service/register_service.dart';
import 'package:mobile_project/utils/constants.dart';

class RegistersPage extends StatefulWidget {
  const RegistersPage({Key? key}) : super(key: key);

  @override
  RegistersPageState createState() => RegistersPageState();
}

class RegistersPageState extends State<RegistersPage> {
  FireStoreService fireStoreService = FireStoreService();
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  String email = "";

  Future<void> getEmail() async {
    final newEmail = await secureStorage.read(key: Constants.userEmail) ?? '';
    setState(() {
      email = newEmail;
    });
  }

  @override
  void initState() {
    getEmail();
    super.initState();
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registers'),
      ),
      body: ListView.builder(
        itemCount: registerList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5, // Set the elevation for a card effect
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.grey[200],
            child: ListTile(
              title: Text(
                registerList[index].registerName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RegisterDetailPage(
                    registerName: registerList[index].registerName,
                  ),
                ));
              },
            ),
          );
        },
      ),
    );
  }
}
