import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_project/models/register.dart';
import 'package:intl/intl.dart';
import 'package:mobile_project/widgets/my_chart.dart';
import 'package:mobile_project/utils/constants.dart';

class RegisterDetailPage extends StatefulWidget {
  final String registerName;

  const RegisterDetailPage({required this.registerName, Key? key}) : super(key: key);

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
      // body: StreamBuilder<DocumentSnapshot>(
      //   stream: FirebaseFirestore.instance
      //       .collection('$email-registers')
      //       .doc(widget.registerName)
      //       .snapshots(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }

      //     var registerData = snapshot.data!.data() as Map<String, dynamic>;
      //     Register register = Register.fromJson(registerData);

      //     List<List<dynamic>> list = processData(register);

      //     return Padding(
      //       padding: const EdgeInsets.all(16.0),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text(
      //             'Last Value: ${register.registerValue.last.value}',
      //             style: TextStyle(fontSize: 18),
      //           ),
      //           const SizedBox(height: 8),
      //           Text(
      //             'Last Date: ${formatDateTime(register.registerValue.last.date)}',
      //             style: TextStyle(fontSize: 18),
      //           ),
      //           const SizedBox(height: 8),
      //           Text(
      //             'Okunan register değer sayısı: ${register.registerValue.length}',
      //             style: TextStyle(fontSize: 18),
      //           ),
      //           SizedBox(height: 16),
      //           MyChart(
      //             list: list,
      //             registerName: widget.registerName,
      //           ),
      //           Expanded(
      //             child: ListView.builder(
      //               //reverse: false, // Liste sıralamasını ters çevir
      //               // physics: BouncingScrollPhysics(), // Kaydırmayı ekler

      //               itemCount: register.registerValue.length,
      //               itemBuilder: (context, index) {
      //                 var value = register.registerValue[index];
      //                 return ListTile(
      //                   title: Text(formatDateTime(value.date)),
      //                   subtitle: Text('Value: ${value.value}'),
      //                 );
      //               },
      //             ),
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }
}
