import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


// Class for handling app localizations
class AppLocalizations {
  // The locale for which the app is localized
  final Locale locale;
  // Map to hold the localized strings
  Map<String, String> _localizedStrings = {};


  // Constructor
  AppLocalizations(this.locale);


  // Method to get the current instance of AppLocalizations
  static AppLocalizations of(BuildContext context) {
    // Try to get the localization for the current context, if not available, default to English
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ?? AppLocalizations(Locale('en'));
  }


  // Method to load the localized strings
  Future<bool> load() async {
    // Load the localization file from the assets
    String jsonString = await rootBundle.loadString('assets/locales/${locale.languageCode}.json');
    // Decode the JSON
    Map<String, dynamic> jsonMap = json.decode(jsonString);


    // Convert the dynamic values to String and store them in the _localizedStrings map
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });


    // Return true when loading is done
    return true;
  }


  // Method to get a localized string
  String translate(String key) {
    // Return the localized string if it exists, otherwise return a default message
    return _localizedStrings[key] ?? 'Key not found';
  }
}