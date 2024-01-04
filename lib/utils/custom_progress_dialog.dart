import 'package:flutter/material.dart';

class CustomProgressDialog extends StatelessWidget {
  final String title;
  final String content;
  final int secondsToWait;
  final double titleFontSize; // Yeni özellik: title metni boyutu

  CustomProgressDialog({
    required this.title,
    required this.content,
    required this.secondsToWait,
    this.titleFontSize = 20.0, // Varsayılan boyut 20.0
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: titleFontSize), // Title metni boyutu ayarlanıyor
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 8),
          Text(content),
        ],
      ),
    );
  }

  Future<void> show(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return this;
      },
    );

    await Future.delayed(Duration(seconds: secondsToWait));

    Navigator.of(context).pop();
  }
}
