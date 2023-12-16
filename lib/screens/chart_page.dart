import 'package:flutter/material.dart';

import '../widgets/line_chart_widget.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chart Page"),
      ),
      //body: LineChartWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Grafik Sayfası Buraya entegre edilecek")],
        ),
      ),
    );
  }
}
