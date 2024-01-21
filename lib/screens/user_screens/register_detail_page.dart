import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_project/models/register.dart';
import 'package:intl/intl.dart';
import 'package:mobile_project/screens/user_screens/my_chart.dart';
import 'package:mobile_project/widgets/my_chart.dart';
import 'package:mobile_project/utils/constants.dart';

class RegisterDetailPage extends StatefulWidget {
  final String registerName;

  const RegisterDetailPage({required this.registerName, Key? key})
      : super(key: key);

  @override
  State<RegisterDetailPage> createState() => _RegisterDetailPageState();
}

class _RegisterDetailPageState extends State<RegisterDetailPage> {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  String email = "";

  Future<void> getEmail() async {
    final newEmail = await secureStorage.read(key: Constants.userEmail) ?? '';
    setState(() {
      email = newEmail;
    });
  }

  List<List<dynamic>> processData(Register register) {
    List<String> dateList = [];
    List<int> valueList = [];

    register.registerValue.forEach((e) {
      dateList.add(formatDateTime(e.date));
      valueList.add(int.parse(e.value));
    });

    return [dateList, valueList];
  }

  @override
  void initState() {
    getEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.registerName),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.grey.shade500,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('$email-registers')
                    .doc(widget.registerName)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  var registerData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  Register register = Register.fromJson(registerData);

                  List<List<dynamic>> list = processData(register);

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 16),
                        _buildInfoCard(
                          'Last Value',
                          '${register.registerValue.last.value}',
                        ),
                        SizedBox(height: 16),
                        _buildInfoCard(
                          'Okunan Register Değeri Sayısı',
                          '${register.registerValue.length}',
                        ),
                        SizedBox(height: 16),
                        MyChart(
                          registerName: widget.registerName,
                        ),
                        SizedBox(height: 16),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Text(
                                'Okunan son 25 Değer',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: register.registerValue.length > 25
                              ? 25
                              : register.registerValue.length,
                          itemBuilder: (context, index) {
                            var reversedIndex =
                                register.registerValue.length - index - 1;
                            var value = register.registerValue[reversedIndex];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: Center(
                                  child: Text(
                                    'Value: ${value.value}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }
}
