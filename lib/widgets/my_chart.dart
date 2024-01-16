import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:quiver/iterables.dart';
import 'package:intl/intl.dart';

class MyChartWidget extends StatelessWidget {
  final String registerName;
  final List<List<dynamic>> list;

  const MyChartWidget({Key? key, required this.registerName, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 300,
          child: Chart(
            data: zip(list).toList(),
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
                on: {GestureType.scaleUpdate, GestureType.tapDown, GestureType.longPressMoveUpdate},
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
          ),
        ),
        const SizedBox(height: 8),
        Text(registerName)
      ],
    );
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }
}
