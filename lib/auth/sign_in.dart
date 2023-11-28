import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/home_page.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String emails = "mehmet.copur@gmail.com";
  String password = "123456";


  void initState() {
    super.initState();
    // Initialize Firebase
    Firebase.initializeApp();
  }

  // Function to sign in with email and password
  Future<void> signInWithEmailAndPassword(BuildContext context,String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if the login is successful
      if (userCredential.user != null) {
        // Navigate to the home page upon successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage(title: 'kjhkj')),
        );
      } else {
        // Handle the case when userCredential.user is null (unsuccessful login)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed. Check your email and password.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print("Error: $e");
      // Handle errors here, e.g., show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed. Check your email and password.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }


  String firebaseEmails = "yasasin.mobil@gmail.com";
  String firebasePassword = "123456";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey],
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: 20),
                  LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}