import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/widgets/custom_show_alert_message.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Form doğrulama anahtarı

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> resetPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      String enteredEmail = _emailController.text.trim();

      try {
        await _auth.sendPasswordResetEmail(email: enteredEmail);
        // // E-posta gönderildiğinde başarılı olduğunu kullanıcıya bildirin
        ShowMessage().showMessage(context, "Şifre Sıfırlama", "Şifre sıfırlama bağlantısı e-posta adresinize gönderildi. Lütfen e-postanızı kontrol edin.");
      } catch (e) {
        print("Error sending password reset email: $e");
        // Hata durumunda kullanıcıya bir hata mesajı gösterin
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: Text("Hata"),
        //       content: Text(
        //           "Şifre sıfırlama bağlantısı gönderilemedi. Lütfen geçerli bir e-posta adresi girin."),
        //       actions: [
        //         TextButton(
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //           },
        //           child: Text("Tamam"),
        //         ),
        //       ],
        //     );
        //   },
        // );
        ShowMessage().showMessage(context, "Hata", "Şifre sıfırlama bağlantısı gönderilemedi. Lütfen geçerli bir e-posta adresi girin.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Reset Password?", style: TextStyle(fontSize: 40)),
              Text("Enter the email address associated with your account.", style: TextStyle(fontSize: 18)),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'E-posta boş bırakılamaz';
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Geçerli bir e-posta adresi girin';
                  }
                  return null; // Geçerli
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  resetPassword();
                },
                child: Text('Reset Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
