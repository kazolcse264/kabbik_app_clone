

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kabbik_ui_clone/src/constants/colors.dart';
import 'package:kabbik_ui_clone/src/features/auth/screens/auth/auth_checking_page.dart';

import '../../../../common_widgets/custom_text_field.dart';

import '../../../../utils/global_functions.dart';

//@RoutePage()
class ResetPasswordPage extends StatefulWidget {
  static const String routeName = '/reset_password';
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Reset Password'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 80.0,
                right: 80.0,
                bottom: 40.0,
              ),
              child: Text(
                'Receive an email to reset your password',
                style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 25,
                ),
              ),
            ),

            CustomTextFormField(
              controller: _emailController,
              label: 'Enter Email',
              hint: 'Enter your Email',
              icon: Icons.email,
              isObscured: false,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
            ),
            buildElevatedButton(
              onPressed: () => resetPassword(context),
              text: 'Reset Password',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildElevatedButton({
    required VoidCallback onPressed,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: const ButtonStyle(
          minimumSize: MaterialStatePropertyAll(Size(400, 50)),
          maximumSize: MaterialStatePropertyAll(Size(400, 50)),
          elevation: MaterialStatePropertyAll(5),
          shadowColor: MaterialStatePropertyAll(Colors.grey),
          backgroundColor: MaterialStatePropertyAll(kWhiteColor),
          padding: MaterialStatePropertyAll(
            EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 8,
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: kBlackColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Future<void> resetPassword(BuildContext context) async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      // After successful login, navigate to the HomePage.
      if (mounted) {
        Navigator.of(context).pushNamed(AuthCheckingPage.routeName);
      }
    } on FirebaseAuthException catch (e) {
      // Handle sign-in errors here.
      if (mounted) {
        showMsg(context, e.message!.toString(), second: 3);
      }
    }

    if (mounted) {
      //context.router.popUntil((route) => route.isFirst);
    }
  }
}
