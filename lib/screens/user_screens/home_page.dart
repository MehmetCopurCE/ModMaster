import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/screens/user_screens/chart_page.dart';
import 'package:mobile_project/screens/user_screens/registers_page.dart';
import 'package:mobile_project/screens/main_page.dart'; 
import '../../auth/screens/login_page.dart';
import 'package:mobile_project/screens/user_screens/home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

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
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Change the background color
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Merhaba!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo, // Change the text color
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Uygulamaya Hoş Geldiniz',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RegistersPage(),
                  ));
                },
                icon: const Icon(Icons.book),
                label: const Text('Registers'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo, // Change the button color
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              const SizedBox(height: 10), // Add some spacing
              // You can add more buttons if needed
            ],
          ),
        ),
      ),
    );
  }
}
