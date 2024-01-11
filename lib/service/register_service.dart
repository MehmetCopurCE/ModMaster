import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_project/data/register_list.dart';
import 'package:mobile_project/models/register.dart';

List<Register> registerList = [];

class RegisterService {
  void createRegisterList(List<Map<String, dynamic>> registerMapList) {
    List<Register> list = [];

    for (Map<String, dynamic> registerMap in registerMapList) {
      Register register = Register(
        registerName: registerMap["registerName"],
        registerAddress: registerMap["registerAddress"],
        registerValue: List<RegisterValue>.from(registerMap["registerValue"].map((x) => RegisterValue.fromJson(x))),
        displayName: registerMap["displayName"],
      );

      list.add(register);
    }

    registerList = list;
    print('Register List generated successfully');
  }

  int getRegisterCount(List<Map<String, dynamic>> registerList) {
    return registerList.length;
  }

  List<int> getDummyList() {
    List<int> list = [];
    print(mapRegisterList.length);
    for (int i = 0; i < mapRegisterList.length; i++) {
      var newValue = Random().nextInt(500);
      list.add(newValue);
      //4095
    }
    print('Dummy List Generated');
    // for (var element in list) {
    //   print(element);
    // }
    return list;
  }
}
