import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kabbik_ui_clone/src/features/auth/screens/auth/auth_page.dart';
import 'package:kabbik_ui_clone/src/features/auth/screens/verify_email/verify_email_page.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/audio_playing_screen/imports.dart';

class AuthCheckingPage extends StatelessWidget {
  static const String routeName = '/';

  const AuthCheckingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Something went wrong!!!',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            return const VerifyEmailPage();
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
