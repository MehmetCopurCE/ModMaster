// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:intl/intl.dart';
// import 'package:mobile_project/models/register.dart';
// import 'package:mobile_project/utils/constants.dart'; // Import your Register model

// class ChartPage2 extends StatefulWidget {
//   final List<RegisterValue>
//       registerValues; // Assuming you have a list of RegisterValues

//   ChartPage2({required this.registerValues});

//   @override
//   State<ChartPage2> createState() => _ChartPage2State();
// }

// class _ChartPage2State extends State<ChartPage2> {
//   FlutterSecureStorage secureStorage = const FlutterSecureStorage();
//   String email = "";

//   Future<void> getEmail() async {
//     final newEmail = await secureStorage.read(key: Constants.checkLogin) ?? '';
//     setState(() {
//       email = newEmail;
//     });
//   }

//   @override
//   void initState() {
//     getEmail();
//     super.initState();
//   }

//   Future<List<RegisterValue>> getRegisterValuesFromFirestore() async {
//     String email =
//         "user@example.com"; // Kullanıcının e-posta adresini buraya ekleyin
//     CollectionReference registerCollection =
//         FirebaseFirestore.instance.collection('$email-registers');

//     try {
//       QuerySnapshot querySnapshot = await registerCollection
//           .doc("Register 0")
//           .collection("registerValues")
//           .get();

//       List<RegisterValue> registerValues = querySnapshot.docs.map((doc) {
//         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//         return RegisterValue(
//           date: data['date'].toDate(),
//           value: data['value'],
//         );
//       }).toList();

//       return registerValues;
//     } catch (e) {
//       print("Hata oluştu: $e");
//       return [];
//     }
//   }

// // Kullanım
// // List<RegisterValue> registerValues = await getRegisterValuesFromFirestore();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chart Page'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: LineChart(
//                 LineChartData(
//                   gridData: FlGridData(show: false),
//                   titlesData: FlTitlesData(
//                     leftTitles: SideTitles(showTitles: true),
//                     bottomTitles: AxisTitles(
//                       showTitles: true,
//                       reservedSize: 22,
//                       margin: 10,
//                       getTitles: (value) {
//                         int index = value.toInt();
//                         if (index >= 0 && index < registerValues.length) {
//                           DateTime date = registerValues[index].date;
//                           return DateFormat('HH:mm:ss').format(date);
//                         }
//                         return '';
//                       },
//                     ),
//                   ),
//                   borderData: FlBorderData(show: true),
//                   lineBarsData: [
//                     LineChartBarData(
//                       spots: List.generate(
//                         registerValues.length,
//                         (index) {
//                           return FlSpot(index.toDouble(),
//                               registerValues[index].value.toDouble());
//                         },
//                       ),
//                       isCurved: true,
//                       colors: [Colors.blue],
//                       dotData: FlDotData(show: false),
//                       belowBarData: BarAreaData(show: false),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
