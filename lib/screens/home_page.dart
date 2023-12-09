import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/screens/register_list_page.dart';
import 'package:mobile_project/screens/registers_page.dart';
import '../auth/screens/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ));
    } catch (e) {
      debugPrint('Oturum kapatma hatası: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Ekran'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hoş geldiniz!'),
            const SizedBox(height: 30),
            Text('Firebase Auth Çıkış İçin Tıklayın'),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _signOut, child: Text("Sign out")),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RegistersPage(),
                ));
              },
              child: Text("Registers Page"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RegisterListPage(),
                ));
              },
              child: Text("Registers List Page Database"),
            ),
          ],
        ),
      ),
    );
  }
}
