import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowMessage {
  void showMessage(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              AppLocalizations.of(context)?.ok ?? '',
              style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> showConfirmationMessage(
    BuildContext context,
    String title,
    String message,
  ) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          content: Text(
            message,
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                AppLocalizations.of(context)?.no ?? 'No',
                style: const TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                AppLocalizations.of(context)?.ok ?? '',
                style: const TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }
}
