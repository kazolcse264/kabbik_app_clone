import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/dashboard/imports.dart';

import '../../../core/screens/dashboard/preserving_bottom_nav_bar.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer(const Duration(seconds: 3), () => checkEmailVerified());
    }
    super.initState();
  }

  Future<void> checkEmailVerified() async {
    ///call after email verification
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future<void> sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      if (mounted) {
        if (kDebugMode) {
          print(e.toString());
        }
        showMsg(context, e.toString(), second: 5);
      }
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const PreservingBottomNavBar()// HomePage()
      : Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: const Text(
              'Verify Email',
              style: TextStyle(
                fontSize: 24,
                color: kWhiteColor,
                letterSpacing: 1.5,
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'A verification email has been sent to your email',
                  style: TextStyle(
                    fontSize: 20,
                    color: kWhiteColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kWhiteColor,
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: () =>
                      canResendEmail ? sendVerificationEmail() : null,
                  icon: const Icon(Icons.email),
                  label: const Text(
                    'Resent Email',
                    style: TextStyle(
                      fontSize: 24,
                      color: kBlackColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 24,
                      color: kWhiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
}
