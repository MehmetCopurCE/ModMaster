import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/widgets/custom_show_alert_message.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  ForgotPasswordFormState createState() => ForgotPasswordFormState();
}

class ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

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
                ElevatedButton(
                  onPressed: () {
                    _resetPassword();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Send',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> myResetPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      String enteredEmail = _emailController.text.trim();

      try {
        //await _auth.sendPasswordResetEmail(email: enteredEmail);
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

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text,
        );

        ShowMessage().showMessage(context, "Reset Password Successfully!", "Password reset email sent. Please check your inbox.");

      } on FirebaseAuthException catch (e) {
        debugPrint("FirebaseAuthException: $e");

        String errorMessage = '';

        switch (e.code) {
          case 'invalid-email':
            errorMessage = 'The email address is badly formatted.';
            break;
          case 'user-not-found':
            errorMessage = 'No user found with this email.';
            break;
          default:
            errorMessage = 'Password reset failed. Please try again later.';
        }

        ShowMessage().showMessage(context, "Reset Password Failed", errorMessage);
      } catch (e) {
        debugPrint("Error: $e");
        // Handle other errors here
        ShowMessage().showMessage(context, "Reset Password Failed", "Please try again later.");
      }
    }
  }
}
