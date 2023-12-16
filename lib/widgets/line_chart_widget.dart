// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// import 'package:firebase_core/firebase_core.dart';


// class LineChartWidget extends StatelessWidget {
//   final List<Color> gradientColors = [
//     const Color(0xff23b6e6),
//     const Color(0xff02d39a),
//   ];



//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       LineChartData(
//         minX: 0,
//         maxX: 11,
//         minY: 0,
//         maxY: 6,
//         titlesData: LineTitles().getTitleData(),

//         gridData: FlGridData(
//           show: true,
//           getDrawingHorizontalLine: (value) {
//             return FlLine(
//               color: const Color(0xff37434d),
//               strokeWidth: 1,
//             );
//           },
//           drawVerticalLine: true,
//           getDrawingVerticalLine: (value) {
//             return FlLine(
//               color: const Color(0xff37434d),
//               strokeWidth: 1,
//             );
//           },
//         ),
//         borderData: FlBorderData(
//           show: true,
//           border: Border.all(color: const Color(0xff37434d), width: 1),
//         ),
//         lineBarsData: [
//           LineChartBarData(
//             spots: [
//               FlSpot(0, 3),
//               FlSpot(2.6, 2),
//               FlSpot(4.9, 5),
//               FlSpot(6.8, 2.5),
//               FlSpot(8, 4),
//               FlSpot(9.5, 3),
//               FlSpot(11, 4),
//             ],
//             //LineChartBarData( databaseden veri çekmek istersek
//             //spots: spots,
//             //isCurved: true,
//             // Diğer özellikler
//             //),
//             isCurved: true,

//             color: Colors.lightBlueAccent.withOpacity(0.3),
//             barWidth: 5,

//             // dotData: FlDotData(show: false),
//             belowBarData: BarAreaData(
//               show: true,
//               color: Colors.greenAccent.withOpacity(0.3),

//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// LineTitles lineTitles = LineTitles();
// final FlTitlesData titlesData = lineTitles.getTitleData();


// class LineTitles {
//   FlTitlesData getTitleData() => FlTitlesData(
//     show: true,
//     bottomTitles: AxisTitles(
//       sideTitles: SideTitles(
//         showTitles: false,
//         // titleTextStyle: TextStyle(
//         //   color: const Color(0xff68737d),
//         //   fontWeight: FontWeight.bold,
//         //   fontSize: 16,
//         // ),
//         getTitlesWidget: (value, titleMeta) {
//           // Replace this with your custom widget, for example:
//           return Text(
//             value.toString(),
//             // style: TextStyle(
//             //   color: Colors.blue,
//             //   fontWeight: FontWeight.bold,
//             //   fontSize: 16,
//             // ),
//           );
//         },
//         reservedSize: 35,
//         //margin: 8,
//       ),
//     ),

//     leftTitles: AxisTitles(
//       sideTitles:  SideTitles(
//         showTitles: false,
//         // titleTextStyle: TextStyle(
//         //   color: const Color(0xff67727d),
//         //   fontWeight: FontWeight.bold,
//         //   fontSize: 15,
//         // ),
//         getTitlesWidget: (value, titleMeta) {
//           // Replace this with your custom widget, for example:
//           return Text(
//             value.toString(),
//             // style: TextStyle(
//             //   color: Colors.blue,
//             //   fontWeight: FontWeight.bold,
//             //   fontSize: 16,
//             // ),
//           );
//         },
//         // getTitle: (value) {
//         //   switch (value.toInt()) {
//         //     case 1:
//         //       return '10k';
//         //     case 3:
//         //       return '30k';
//         //     case 5:
//         //       return '50k';
//         //   }
//         //   return '';
//         // },
//         reservedSize: 35,
//         //margin: 12,
//         //rotateAngle: 90,
//       ),

//     ),

//   );
// }

