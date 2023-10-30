import 'package:flutter/material.dart';
import 'package:kabbik_ui_clone/src/features/auth/screens/sign_in/sign_in_page.dart';

import '../sign_up/sign_up_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogIn = true;

  @override
  Widget build(BuildContext context) => isLogIn
      ? SignInPage(onClickedSignUp: toggle)
      : SignUpPage(onClickedSignIn: toggle);

  void toggle() => setState(() => isLogIn = !isLogIn);
}
