import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:mobile_project/data/echarts_data.dart';
import 'package:quiver/iterables.dart';

class EchartsPage extends StatelessWidget {
  EchartsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 350,
            height: 300,
            child: Chart(
              data: zip(lineSectionsData).toList(),
              variables: {
                'time': Variable(
                  accessor: (List datum) => datum[0] as String,
                  scale: OrdinalScale(inflate: true, tickCount: 6),
                ),
                'value': Variable(
                  accessor: (List datum) => datum[1] as String,
                  scale: LinearScale(
                    max: 800,
                    min: 0,
                    formatter: (v) => '${v.toInt()} W',
                  ),
                ),
              },
              marks: [
                LineMark(
                  shape: ShapeEncode(value: BasicLineShape(smooth: true)),
                )
              ],
              axes: [
                Defaults.horizontalAxis,
                Defaults.verticalAxis,
              ],
              selections: {
                'tooltipMouse': PointSelection(on: {
                  GestureType.hover,
                }, devices: {
                  PointerDeviceKind.mouse
                }, dim: Dim.x),
                'tooltipTouch': PointSelection(on: {
                  GestureType.scaleUpdate,
                  GestureType.tapDown,
                  GestureType.longPressMoveUpdate
                }, devices: {
                  PointerDeviceKind.touch
                }, dim: Dim.x),
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
        ],
      ),
    );
  }
}
