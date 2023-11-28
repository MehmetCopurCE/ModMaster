import 'package:flutter/material.dart';

class ShowMessage {
  void showMessage(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        content: Text(
          content,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Tamam'),
          ),
        ],
      ),
    );
  }

// Future<bool> showConfirmationMessage(
//     BuildContext context,
//     String title,
//     String message,
//     ) async {
//   bool? result = await showDialog<bool>(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(false);
//             },
//             child: Text('Hayır'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(true);
//             },
//             child: Text('Evet'),
//           ),
//         ],
//       );
//     },
//   );
//
//   // Return a default value if the user dismisses the dialog
//   return result ?? false;
// }
}
