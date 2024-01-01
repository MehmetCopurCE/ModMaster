import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mobile_project/auth/widgets/login_form.dart';
import 'package:mobile_project/models/register.dart';
import 'package:mobile_project/screens/user_screens/register_detail_page.dart';
import 'package:mobile_project/service/firestore_service.dart';
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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('$email-registers')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('Register Yok'),
            );
          }

          var registers = snapshot.data!.docs;

          return ListView.builder(
            itemCount: registers.length,
            itemBuilder: (context, index) {
              var registerData =
              registers[index].data() as Map<String, dynamic>;
              Register register = Register.fromJson(registerData);
              RegisterValue latestValue = register.registerValue.last;

              return Card(
                elevation: 5, // Set the elevation for a card effect
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.grey[200],
                child: ListTile(
                  title: Text(register.registerName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    'Last Date: ${formatDateTime(latestValue.date)} - Last Value: ${latestValue.value}',
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RegisterDetailPage(
                        registerName: register.registerName,
                      ),
                    ));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}