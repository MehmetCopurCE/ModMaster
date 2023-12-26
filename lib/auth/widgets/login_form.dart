import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_project/auth/service/auth_service.dart';
import 'package:mobile_project/screens/main_page.dart';
import 'package:mobile_project/service/firestore_service.dart';
import 'package:mobile_project/service/register_service.dart';
import 'package:mobile_project/utils/constants.dart';
import 'package:mobile_project/utils/custom_show_alert_message.dart';
import '../../screens/user_screens/home_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //FireStoreService fireStoreService = FireStoreService();
  AuthService authService = AuthService();

  bool passwordSecure = true;

  @override
  void initState() {
    _emailController.text = "lorem.ipsum@gmail.com";
    _passwordController.text = "123456";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       "Sign In",
                //       style: TextStyle(fontWeight: FontWeight.bold),
                //     ),
                //   ],
                // ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.mail),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: passwordSecure,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    // suffixIcon: IconButton(
                    //   onPressed: () {
                    //     setState(() {
                    //       passwordSecure = !passwordSecure;
                    //     });
                    //   },
                    //   icon: Icon(passwordSecure
                    //       ? Icons.visibility_off
                    //       : Icons.visibility),
                    // ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: !passwordSecure,
                      onChanged: (value) {
                        setState(() {
                          passwordSecure = !passwordSecure;
                        });
                      },
                    ),
                    const Text("Show Password")
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _login();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Login',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        // UserCredential userCredential =
        //     await FirebaseAuth.instance.signInWithEmailAndPassword(
        //   email: _emailController.text,
        //   password: _passwordController.text,
        // );

        User? user = await authService.login(
            _emailController.text, _passwordController.text);

        if (user != null) {
          // await secureStorage.write(
          //     key: Constants.userEmail, value: _emailController.text);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNavy()),
          );
        } else {
          //_showErrorSnackbar('Login failed. Check your email and password.');
          ShowMessage().showMessage(
              context, "Login Failed", "Check your email and password.");
        }
      } on FirebaseAuthException catch (e) {
        debugPrint("FirebaseAuthException: $e");

        String errorMessage = '';

        switch (e.code) {
          case 'user-not-found':
            errorMessage = 'No user found with this email.';
            break;
          case 'wrong-password':
            errorMessage = 'Wrong password provided for this user.';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is badly formatted.';
            break;
          default:
            errorMessage = 'Login failed. Check your email and password.';
        }
        //_showErrorSnackbar(errorMessage);
        ShowMessage().showMessage(context, "Login Error", errorMessage);
      } catch (e) {
        debugPrint("Error: $e");
        //_showErrorSnackbar('Login failed. Check your email and password.');
        ShowMessage().showMessage(
            context, "Login failed", "Check your email and password.");
      }
    }
  }

// void _showErrorSnackbar(String errorMessage) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(errorMessage),
//       duration: const Duration(seconds: 3),
//     ),
//   );
// }
}
