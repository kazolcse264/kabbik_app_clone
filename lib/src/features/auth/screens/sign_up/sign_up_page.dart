import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kabbik_ui_clone/main.dart';
import 'package:kabbik_ui_clone/src/features/auth/screens/auth/auth_checking_page.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/dashboard/imports.dart';
import '../../../../common_widgets/custom_app_bar.dart';
import '../../../../common_widgets/custom_text_field.dart';

//@RoutePage()
class SignUpPage extends StatefulWidget {
  static const String routeName = '/sign_up';
  final Function() onClickedSignIn;

  const SignUpPage({super.key, required this.onClickedSignIn});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: const CustomAppBar(
        title: 'Sign Up Page',
        backgroundColor: kPrimaryColor, // Set your custom color here
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                  controller: _emailController,
                  label: 'Enter Email',
                  hint: 'Enter your email address',
                  icon: Icons.email,
                  isObscured: false,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                ),
                CustomTextFormField(
                  controller: _passwordController,
                  label: 'Enter Password',
                  hint: 'Enter your password',
                  icon: Icons.password,
                  isObscured: true,
                  textInputAction: TextInputAction.done,
                ),
                buildElevatedIconButton(
                    onPressed: () => signUp(context),
                    text: 'Sign Up',
                    icon: Icons.person_add),
                const SizedBox(
                  height: 10,
                ),
                buildRichText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  RichText buildRichText() {
    return RichText(
                text: TextSpan(
                    text: 'Already have an Account? ',
                    style: const TextStyle(color: kWhiteColor),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignIn,
                        text: 'Sign In',
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: kWhiteColor,
                          fontSize: 20,
                        ),
                      )
                    ]),
              );
  }

  Widget buildElevatedIconButton({
    required VoidCallback onPressed,
    required String text,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: kWhiteColor,
            minimumSize: const Size.fromHeight(50)),
        icon: Icon(
          icon,
          color: kBlackColor,
        ),
        label: Text(
          text,
          style: const TextStyle(
            color: kBlackColor,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  Future<void> signUp(BuildContext context) async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(color: kWhiteColor,),
          );
        });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // After successful login, navigate to the HomePage.
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AuthCheckingPage.routeName);
      }
    } on FirebaseAuthException catch (e) {
      // Handle sign-in errors here.
      if (mounted) {
        showMsg(context, e.message!.toString(), second: 3);
      }
    }

    if (mounted) {
     navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }
}
