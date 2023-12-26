import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_project/data/register_list.dart';
import 'package:mobile_project/service/firestore_service.dart';
import 'package:mobile_project/utils/constants.dart';
import 'package:mobile_project/utils/custom_show_alert_message.dart';

class AuthService {
  FireStoreService fireStoreService = FireStoreService();
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        debugPrint('Giriş yapıldı kullanıcı null değil');
        await secureStorage.write(
            key: Constants.userEmail, value: userCredential.user!.email);
        fireStoreService.addRegistersToFirestore(registerList, email);
        return userCredential.user;
      } else {
        debugPrint('Giriş yapılamadı kullanıcı null geldi');
      }
    } catch (e) {
      debugPrint('FireStoreService de login işlemi catch e düştü');
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await secureStorage.write(
          key: Constants.userEmail,
          value: ''); //Çıkış yapılırsa kayıtlı kullanıcı mailini siliyoruz
      print('Sign out çağırıldı ve çıkış yapıldı');
    } catch (e) {
      print('Oturum kapatma hatası: $e');
    }
  }

  void showErrorMessage(BuildContext context, String title, String content) {
    ShowMessage().showMessage(context, title, content);
  }

  Future<void> register(BuildContext context, String email, String password,
      String displayName, String phoneNumber) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Oluşturulan kullanıcı nesnesini al
      User? user = userCredential.user;

      // Firestore üzerinde kullanıcı profili için bir belge oluştur
      await FirebaseFirestore.instance.collection('users').doc(email).set({
        'email': email,
        'password': password,
        'displayName': displayName,
        'phoneNumber': phoneNumber
        // Diğer özel bilgileri buraya ekleyebilirsiniz.
      });

      print('Kullanıcı kaydı başarılı: $email');
      await secureStorage.write(key: Constants.userEmail, value: email);

      await fireStoreService.addRegistersToFirestore(registerList, email);
    } on FirebaseAuthException catch (e) {
      debugPrint("FirebaseAuthException: $e");

      String errorMessage = '';

      switch (e.code) {
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          errorMessage = 'The account already exists for that email.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is badly formatted.';
          break;
        default:
          errorMessage = 'Registration failed. Please try again later.';
      }

      //ShowMessage().showMessage(context, "Registeration Failed", errorMessage);
      showErrorMessage(context, "Registeration Failed", errorMessage);
    } catch (e) {
      debugPrint("Error: $e");
      //ShowMessage().showMessage(context, "Registeration Failed", "Please try again later.");
      showErrorMessage(
          context, "Registeration Failed", "Please try again later.");
    }
  }
}
