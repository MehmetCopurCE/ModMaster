import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/data/register_list.dart';
import 'package:mobile_project/service/firestore_service.dart';
import 'package:mobile_project/widgets/custom_show_alert_message.dart';

class AuthService {
  FireStoreService fireStoreService = FireStoreService();

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        debugPrint('Giriş yapıldı kullanıcı null değil');
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
      print('Sign out çağırıldı ve çıkış yapıldı');
    } catch (e) {
      print('Oturum kapatma hatası: $e');
    }
  }

  void showErrorMessage(BuildContext context, String title, String content) {
    ShowMessage().showMessage(context, title, content);
  }

  Future<void> register(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

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
