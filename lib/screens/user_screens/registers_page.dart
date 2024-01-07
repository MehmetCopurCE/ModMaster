import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mobile_project/models/register.dart';
import 'package:mobile_project/screens/user_screens/register_detail_page.dart';
import 'package:mobile_project/utils/constants.dart';
import 'package:mobile_project/provider/register_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegistersPage extends ConsumerStatefulWidget {
  late String email = ''; // Define email as an instance variable

  RegistersPage({Key? key}) : super(key: key);

  @override
  ConsumerState<RegistersPage> createState() => _RegistersPageState();
}

class _RegistersPageState extends ConsumerState<RegistersPage> {
  late final FlutterSecureStorage secureStorage;

  @override
  void initState() {
    secureStorage = FlutterSecureStorage();
    getEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Read the Riverpod state
    final registers = ref.read(registerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registers'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('${widget.email}-registers')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Register Yok'),
            );
          }

          var firestoreRegisters = snapshot.data!.docs;

          return ListView.builder(
            itemCount: firestoreRegisters.length,
            itemBuilder: (context, index) {
              var registerData = firestoreRegisters[index].data();
              Register register = Register.fromJson(registerData);
              RegisterValue latestValue = register.registerValue.last;

              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.grey[200],
                child: ListTile(
                  title: Text(
                    register.registerName,
                    style: const TextStyle(
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

  String formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  Future<void> getEmail() async {
    final newEmail = await secureStorage.read(key: Constants.userEmail) ?? '';
    setState(() {
      widget.email = newEmail;
    });
  }
}
