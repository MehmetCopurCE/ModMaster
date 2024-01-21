import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/utils/custom_show_alert_message.dart';
import 'package:mobile_project/auth/widgets/forgot_password_form.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        ShowMessage().showMessage(
            context,
            AppLocalizations.of(context)?.passwordResetTitle ?? " ",
            AppLocalizations.of(context)?.passwordResetMessage ?? "");
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
        ShowMessage().showMessage(
          context,
          AppLocalizations.of(context)?.errorTitle ?? ' ',
          AppLocalizations.of(context)?.passwordResetFailureMessage ?? ' ',
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.resetPasswordTitle ?? ' '),
        centerTitle: true,
        // backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/img_reset_password.png", width: 100),
                Text(
                  AppLocalizations.of(context)?.resetPasswordQuestion ?? " ",
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)?.resetPasswordDescription ?? " ",
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const ForgotPasswordForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
