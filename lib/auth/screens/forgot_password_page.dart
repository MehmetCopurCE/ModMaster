import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/utils/custom_show_alert_message.dart';
import 'package:mobile_project/auth/widgets/forgot_password_form.dart';

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
        ShowMessage().showMessage(context, "Şifre Sıfırlama",
            "Şifre sıfırlama bağlantısı e-posta adresinize gönderildi. Lütfen e-postanızı kontrol edin.");
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
        ShowMessage().showMessage(context, "Hata",
            "Şifre sıfırlama bağlantısı gönderilemedi. Lütfen geçerli bir e-posta adresi girin.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/img_reset_password.png",
                      width: 100),
                  const Text(
                    "Reset Password?",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const Text(
                    "Enter the email address associated with your account.",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const ForgotPasswordForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
