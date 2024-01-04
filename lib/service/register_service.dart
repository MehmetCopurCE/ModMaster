import 'package:flutter/material.dart';

List<String> registerNames = [];

class RegisterService {
  void getRegisterNames(List<Map<String, dynamic>> registerList) {
    try {
      for (var register in registerList) {
        registerNames.add(register["registerName"]);
      }
      debugPrint('Register names getted successfully as a list');
    } catch (e) {
      debugPrint('Error when getting registerNames as a list');
    }
  }

  int getRegisterCount(List<Map<String, dynamic>> registerList) {
    return registerList.length;
  }
}
