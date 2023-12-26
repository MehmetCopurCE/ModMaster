import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/screens/user_screens/chart_page.dart';
import 'package:mobile_project/screens/user_screens/registers_page.dart';
import 'package:mobile_project/screens/main_page.dart'; // Import the MainPage
import '../../auth/screens/login_page.dart';

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

  // Function to navigate to MainPage

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Hoş geldiniz!'),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const RegistersPage(),
              ));
            },
            child: const Text("Registers"),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
