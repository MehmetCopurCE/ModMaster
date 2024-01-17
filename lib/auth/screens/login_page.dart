import 'package:flutter/material.dart';
import 'package:mobile_project/auth/widgets/register_form.dart';
import '../widgets/login_form.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hasAccount = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Login Page'),
      //   backgroundColor: Colors.white,
      // ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(hasAccount ? "assets/images/img_login.png" : "assets/images/img_register.png", width: 100),
                Text(
                  hasAccount ? 'Sign In' : "Sign Up",
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                if (hasAccount)
                  const Column(
                    children: [
                      Text("Email: deneme@gmail.com"),
                      Text("Password: 123456"),
                    ],
                  ),
                const SizedBox(height: 20),
                hasAccount ? LoginForm() : RegisterForm(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (hasAccount)
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
                        ),
                      ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          hasAccount = !hasAccount;
                        });
                      },
                      child: Text(
                        hasAccount ? "Create Account" : "Have Account?",
                        style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
