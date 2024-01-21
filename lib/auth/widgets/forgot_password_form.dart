import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/utils/custom_show_alert_message.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  ForgotPasswordFormState createState() => ForgotPasswordFormState();
}

class ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.email ?? 'Email',
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
                child: Text(
                  AppLocalizations.of(context)?.send ?? 'Send',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text,
        );

        ShowMessage().showMessage(
          context,
          AppLocalizations.of(context)?.resetPasswordSuccessTitle ??
              'Reset Password Successfully!',
          AppLocalizations.of(context)?.resetPasswordSuccessMessage ??
              'Password reset email sent. Please check your inbox.',
        );
      } on FirebaseAuthException catch (e) {
        debugPrint("FirebaseAuthException: $e");

        String errorMessage = '';

        switch (e.code) {
          case 'invalid-email':
            errorMessage =
                AppLocalizations.of(context)?.invalidEmail ?? 'Invalid email';
            break;
          case 'user-not-found':
            errorMessage =
                AppLocalizations.of(context)?.userNotFound ?? 'User not found';
            break;
          default:
            errorMessage = AppLocalizations.of(context)?.resetPasswordFailed ??
                'Password reset failed. Please try again later.';
        }

        ShowMessage().showMessage(
          context,
          AppLocalizations.of(context)?.resetPasswordFailed ??
              'Reset Password Failed',
          errorMessage,
        );
      } catch (e) {
        debugPrint("Error: $e");
        ShowMessage().showMessage(
          context,
          AppLocalizations.of(context)?.resetPasswordFailed ??
              'Reset Password Failed',
          AppLocalizations.of(context)?.tryAgainLater ??
              'Please try again later.',
        );
      }
    }
  }
}
