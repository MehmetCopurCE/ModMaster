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

  Future<void> addRegistersToFirestore(List<Map<String, dynamic>> registerList, String baseCollectionName) async {
    bool isFirst = await checkIsFirst(baseCollectionName);
    final collectionName = '$baseCollectionName-registers';
    print('isFirst: $isFirst');

    try {
      if (isFirst) {
        final CollectionReference registersCollection = FirebaseFirestore.instance.collection(collectionName);

        for (var register in registerList) {
          // Firestore'da belgeyi eklemek
          await registersCollection.doc(register['registerName']).set(register);
        }
        await setFirst(baseCollectionName, "false");

        debugPrint("Register'lar başarıyla Firestore'a eklendi.");
      } else {
        debugPrint('Registers already added to firestore');
      }
      // startPeriodicUpdate(collectionName);
    } catch (e) {
      debugPrint("Hata oluştu: $e");
    }
  }

  // void startPeriodicUpdate(String collectionName) {
  //   Timer.periodic(const Duration(seconds: 5), (Timer timer) {
  //     updateAllRegistersInBatch(collectionName);
  //   });
  // }

  Future<bool> checkIsFirst(String email) async {
    String result = await secureStorage.read(key: '$email-${Constants.isFirst}') ?? 'true';
    return result == "true";
  }

  Future<void> setFirst(String email, String value) async {
    try {
      await secureStorage.write(key: '$email-${Constants.isFirst}', value: value);
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
  Future<void> updateAllRegistersInBatch(String email) async {
    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      final collectionName = '$email-registers';
      final CollectionReference registersCollection = FirebaseFirestore.instance.collection(collectionName);

      for (var register in registerList) {
        DocumentReference docRef = registersCollection.doc(register.registerName);

        // Firestore'dan mevcut belgeyi al
        DocumentSnapshot documentSnapshot = await docRef.get();

        // Firestore belgesinden registerValue alanını al
        List<dynamic> currentRegisterValue = documentSnapshot['registerValue'] ?? [];

        // Yeni date ve value çiftini oluştur
        var newDate = DateTime.now();
        var newValue = Random().nextInt(500);
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

  Future<Map<String, dynamic>> getUserDetailsByEmail(String email) async {
    try {
      final userDocument = await FirebaseFirestore.instance.collection('users').doc(email).get();

      if (userDocument.exists) {
        return userDocument.data() as Map<String, dynamic>;
      } else {
        return {};
      }
    } catch (e) {
      print('Error fetching user details: $e');
      return {};
    }
  }

  Future<void> updateUserDetails(String documentId, Map<String, dynamic> updatedData) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(documentId).update(updatedData);
      print('Kullanıcı bilgileri güncellendi');
    } catch (e) {
      print('Kullanıcı bilgileri güncellenirken hata oluştu: $e');
      // Hata durumunda kullanıcıya bilgi verebilir veya başka bir işlem yapabilirsiniz.
    }
  }
}
