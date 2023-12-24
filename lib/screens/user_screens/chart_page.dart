import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphic/graphic.dart';
import 'package:mobile_project/utils/constants.dart';

import '../../widgets/line_chart_widget.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_project/auth/widgets/login_form.dart';
import 'package:mobile_project/models/register.dart';
import 'package:intl/intl.dart';

class ChartPage extends StatefulWidget {
  final String registerName;

  const ChartPage({Key? key, required this.registerName}) : super(key: key);

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  String email = "";

  Future<void> getEmail() async {
    final newEmail = await secureStorage.read(key: Constants.checkLogin) ?? '';
    setState(() {
      email = newEmail;
    });
  }

  @override
  void initState() {
    getEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('$email-registers')
          .doc(widget.registerName)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var registerData = snapshot.data!.data();
        Register register =
            Register.fromJson(registerData as Map<String, dynamic>);
        if (registerData == null || registerData is! Map<String, dynamic>) {
          // Handle the case where data is null or not in the expected format
          return const Center(
            child: Text('Invalid data format'),
          );
        }

        try {
          Register register = Register.fromJson(registerData);
          print("Parsed Register: $register");

          List<String> dateList = [];
          List<String> valueList = [];

          register.registerValue.forEach((e) {
            dateList.add(formatDateTime(e.date));
            valueList.add(e.value);
          });

          List<List<dynamic>> list = [dateList, valueList];

          return Chart(
            data: list,
            variables: {
              'time': Variable(
                accessor: (List datum) => datum[0] as String,
                scale: OrdinalScale(inflate: true, tickCount: 6),
              ),
              'value': Variable(
                accessor: (List datum) => datum[1] as int,
                scale: LinearScale(
                  max: 800,
                  min: 0,
                  formatter: (v) => '${v.toInt()} W',
                ),
              ),
            },
            marks: [
              // Add this line with your desired marks configuration
              LineMark(
                shape: ShapeEncode(value: BasicLineShape(smooth: true)),
              )
            ],
            axes: [
              Defaults.horizontalAxis,
              Defaults.verticalAxis,
            ],
            selections: {
              'tooltipMouse': PointSelection(
                on: {GestureType.hover},
                devices: {PointerDeviceKind.mouse},
                dim: Dim.x,
              ),
              'tooltipTouch': PointSelection(
                on: {
                  GestureType.scaleUpdate,
                  GestureType.tapDown,
                  GestureType.longPressMoveUpdate
                },
                devices: {PointerDeviceKind.touch},
                dim: Dim.x,
              ),
            },
            tooltip: TooltipGuide(
              followPointer: [true, true],
              align: Alignment.topLeft,
            ),
            crosshair: CrosshairGuide(
              followPointer: [false, true],
            ),
            annotations: [
              RegionAnnotation(
                values: ['07:30', '10:00'],
                color: const Color.fromARGB(120, 255, 173, 177),
              ),
              RegionAnnotation(
                values: ['17:30', '21:15'],
                color: const Color.fromARGB(120, 255, 173, 177),
              ),
            ],
          );
        } catch (e) {
          print("Error parsing Register: $e");
          return Center(
            child: Text('Error parsing Register'),
          );
        }
      },
    );
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }
}
