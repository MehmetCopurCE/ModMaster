import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/auth/screens/login_page.dart';

import 'home_page.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Auth durumu bekleniyor.
        } else if (snapshot.hasData) {
          return HomePage(); // Kullanıcı oturum açtıysa ana ekrana yönlendir.
        } else {
          return LoginPage(); // Kullanıcı oturum açmamışsa veya hesabı yoksa kayıt ekranına yönlendir.
        }
      },
    );
  }
}
