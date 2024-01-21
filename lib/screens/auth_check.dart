import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/auth/screens/login_page.dart';
import 'package:mobile_project/data/register_list.dart';
import 'package:mobile_project/main.dart';
import 'package:mobile_project/screens/main_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator()); // Auth durumu bekleniyor.
        } else if (snapshot.hasData) {
          User? user = FirebaseAuth.instance.currentUser;
          String userEmail = user?.email ?? '';
          print('User Email: $userEmail');

          fireStoreService.addRegistersToFirestore(
              mapRegisterList, userEmail); // Call startPeriodicUpdate here

          return const BottomNavy(); // Kullanıcı oturum açtıysa ana ekrana yönlendir.
        } else {
          return const LoginPage(); // Kullanıcı oturum açmamışsa veya hesabı yoksa kayıt ekranına yönlendir.
        }
      },
    );
  }
}
