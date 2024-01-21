import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/auth/service/auth_service.dart';
import 'package:mobile_project/auth/widgets/login_form.dart';
import 'package:mobile_project/data/register_list.dart';
import 'package:mobile_project/main.dart';
import 'package:mobile_project/screens/auth_check.dart';
import 'package:mobile_project/service/firestore_service.dart';
import 'package:mobile_project/utils/custom_show_alert_message.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  AuthService authService = AuthService();
  FireStoreService fireStoreService = FireStoreService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _checkPasswordController = TextEditingController();

  bool passwordSecure = true;

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _checkPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: [
              // const Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       "Sign Up",
              //       style: TextStyle(fontWeight: FontWeight.bold),
              //     )
              //   ],
  TextFormField(
  controller: _userNameController,
  decoration: InputDecoration(
    labelText: AppLocalizations.of(context)?.usernameLabel ?? 'Username',
    prefixIcon: const Icon(Icons.account_circle),
  ),
  keyboardType: TextInputType.name,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)?.usernameLabel ?? 'Please enter your username';
    }
    return null;
  },
),

              const SizedBox(height: 10),
             TextFormField(
  controller: _emailController,
  decoration: InputDecoration(
    labelText: AppLocalizations.of(context)?.emailLabel ?? 'Email',
    prefixIcon: const Icon(Icons.mail),
  ),
  keyboardType: TextInputType.emailAddress,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)?.enterEmail ?? 'Please enter your email';
    }
    return null;
  },
),

              const SizedBox(height: 10),
             TextFormField(
  controller: _phoneController,
  decoration: InputDecoration(
    labelText: AppLocalizations.of(context)?.phoneNumberLabel ?? 'Phone Number',
    prefixIcon: const Icon(Icons.phone),
  ),
  keyboardType: TextInputType.phone,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)?.enterPhoneNumber ?? 'Please enter your phone number';
    }
    return null;
  },
),

              const SizedBox(height: 10),
             TextFormField(
  controller: _passwordController,
  obscureText: passwordSecure,
  decoration: InputDecoration(
    labelText: AppLocalizations.of(context)?.passwordLabel ?? 'Password',
    prefixIcon: const Icon(Icons.lock),
  ),
  keyboardType: TextInputType.emailAddress,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)?.enterPassword ?? 'Please enter your password';
    } else if (_passwordController.text.length < 4) {
      return AppLocalizations.of(context)?.shortPassword ?? 'Password cannot be less than 4 characters';
    }
    return null;
  },
),
TextFormField(
  controller: _checkPasswordController,
  obscureText: passwordSecure,
  decoration: InputDecoration(
    labelText: AppLocalizations.of(context)?.confirmPasswordLabel ?? 'Confirm Password',
    prefixIcon: const Icon(Icons.lock),
  ),
  keyboardType: TextInputType.emailAddress,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)?.enterPassword ?? '';
    } else if (_checkPasswordController.text.length < 4) {
      return AppLocalizations.of(context)?.shortPassword ?? '';
    } else if (_checkPasswordController.text != _passwordController.text) {
      return AppLocalizations.of(context)?.passwordsDoNotMatch ?? '';
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
                   Text(
  AppLocalizations.of(context)?.showPassword ?? ' ',
),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _register();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
               child: Text(
  AppLocalizations.of(context)?.signUp ?? 'Sign Up',
  style: TextStyle(color: Colors.white),
),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void goAuthCheck() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AuthCheck()),
    );
  }

  // void showErrorMessage(String title, String content) {
  //   ShowMessage().showMessage(context, title, content);
  // }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        authService.register(
          context,
          _emailController.text,
          _passwordController.text,
          _userNameController.text,
          _phoneController.text,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AuthCheck()),
        );
      } catch (e) {
        print('Kayıt oluştururken hata: $e');
      }
    }
  }
}
