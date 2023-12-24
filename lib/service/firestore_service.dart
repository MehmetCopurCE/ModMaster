import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_project/service/register_service.dart';
import 'package:mobile_project/utils/constants.dart';

class FireStoreService {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  // final CollectionReference registersCollection =
  //     FirebaseFirestore.instance.collection('registers');

  Future<void> addRegistersToFirestore(List<Map<String, dynamic>> registerList,
      String baseCollectionName) async {
    bool isFirst = await checkIsFirst();
    final collectionName = '$baseCollectionName-registers';

    try {
      if (isFirst) {
        final CollectionReference registersCollection =
            FirebaseFirestore.instance.collection(collectionName);

        for (var register in registerList) {
          // Firestore'da belgeyi eklemek
          await registersCollection.doc(register['registerName']).set(register);
        }
        await setFirst("false");

        debugPrint("Register'lar başarıyla Firestore'a eklendi.");
      } else {
        debugPrint('Registers already added to firestore');
      }
      startPeriodicUpdate(collectionName);
    } catch (e) {
      debugPrint("Hata oluştu: $e");
    }
  }

  void startPeriodicUpdate(String collectionName) {
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      updateAllRegistersInBatch(collectionName);
    });
  }

  Future<bool> checkIsFirst() async {
    String result = await secureStorage.read(key: Constants.isFirst) ?? 'true';
    return result == "true";
  }

  Future<void> setFirst(String value) async {
    try {
      await secureStorage.write(key: Constants.isFirst, value: value);
      debugPrint('IsFirst setted successfully');
    } catch (e) {
      debugPrint("Error when setting IsFirst set");
    }
  }

  // Future<void> startUpdate() async {
  //   Timer(Duration(seconds: 3), () async {
  //     await updateAllRegistersInBatch();
  //   });
  // }

  ///Tüm registerlara aynı anda yeni değer yazmamızı sağlıyor
  Future<void> updateAllRegistersInBatch(String collectionName) async {
    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      final CollectionReference registersCollection =
          FirebaseFirestore.instance.collection(collectionName);

      for (String registerName in registerNames) {
        DocumentReference docRef = registersCollection.doc(registerName);

        // Firestore'dan mevcut belgeyi al
        DocumentSnapshot documentSnapshot = await docRef.get();

        // Firestore belgesinden registerValue alanını al
        List<dynamic> currentRegisterValue =
            documentSnapshot['registerValue'] ?? [];

        // Yeni date ve value çiftini oluştur
        var newDate = DateTime.now();
        var newValue = Random().nextInt(300);
        var newValueMap = {"date": newDate, "value": newValue};

        // Mevcut registerValue listesine yeni çifti ekle
        currentRegisterValue.add(newValueMap);

        // Batch'e güncelleme işlemini ekle
        batch.update(docRef, {'registerValue': currentRegisterValue});
      }

      // Batch işlemini commit et
      await batch.commit();

      debugPrint('Tüm registerlara yeni değer eklendi (batch)');
    } catch (e) {
      debugPrint('Tüm registerlar güncellenemedi (batch) error: $e');
    }
  }

  // Future<void> addInitialValue2(String registerName) async {
  //   try {
  //     // Firestore'dan mevcut belgeyi al
  //     DocumentSnapshot documentSnapshot =
  //         await registersCollection.doc(registerName).get();

  //     // Firestore belgesinden registerValue alanını al
  //     List<dynamic> currentRegisterValue =
  //         documentSnapshot['registerValue'] ?? [];

  //     // Yeni date ve value çiftini oluştur
  //     var newDate = DateTime.now();
  //     var newValue = Random().nextInt(300);
  //     var newValueMap = {"date": newDate, "value": newValue};

  //     // Mevcut registerValue listesine yeni çifti ekle
  //     currentRegisterValue.add(newValueMap);

  //     // Firestore'da güncelleme yap
  //     await registersCollection
  //         .doc(registerName)
  //         .update({'registerValue': currentRegisterValue});

  //     print("İlk değer başarıyla eklendi.");
  //   } catch (e) {
  //     print("Hata oluştu: $e");
  //   }
  // }

  ///Bu registerlara tek tek yeni değer yazıyor
  // Future<void> updateAllRegisters() async {
  //   try {
  //     for (String registerName in registerNames) {
  //       await addInitialValue2(registerName);
  //     }
  //     debugPrint('Tüm registerlara yeni değer eklendi');
  //   } catch (e) {
  //     debugPrint('Tüm registerlar güncellenemedi error: $e');
  //   }
  // }
}
