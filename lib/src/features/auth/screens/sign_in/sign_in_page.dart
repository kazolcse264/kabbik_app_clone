
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kabbik_ui_clone/src/common_widgets/custom_app_bar.dart';
import 'package:kabbik_ui_clone/src/features/auth/controllers/user_provider.dart';
import 'package:kabbik_ui_clone/src/features/auth/screens/reset_password/reset_password_page.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/dashboard/preserving_bottom_nav_bar.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../../../../../main.dart';
import '../../../../common_widgets/custom_text_field.dart';
import '../../../../constants/colors.dart';
import '../../../../utils/global_functions.dart';
import '../../../core/models/user_model.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = '/sign_in';
  final VoidCallback onClickedSignUp;

  const SignInPage({super.key, required this.onClickedSignUp});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: const CustomAppBar(
        title: 'Sign In Page',
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
                  onPressed: () => signIn(context),
                  text: 'Sign In',
                  icon: Icons.login,
                ),
                const SizedBox(
                  height: 10,
                ),

                 const Text('Or, Sign Up Using',style: TextStyle(
                   color: Colors.white,
                   fontSize: 14,
                 ),),
                const SizedBox(
                  height: 10,
                ),
                 GestureDetector(
                   onTap: () => authenticateWithGoogle(userProvider),
                   child: const CircleAvatar(
                     radius: 25,
                     backgroundColor: kWhiteColor,
                     child: CircleAvatar(
                       backgroundColor: Colors.transparent,
                       backgroundImage: AssetImage('assets/logo/google.png',),
                       radius: 20,
                     ),
                   ),
                 ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(ResetPasswordPage.routeName);
                  },
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
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
                    text: 'No Account?  ',
                    style: const TextStyle(color: kWhiteColor),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignUp,
                        text: 'Sign Up',
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
        icon:  Icon(icon,color: kBlackColor,),
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

  Future<void> signIn(BuildContext context) async {
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // After successful login, navigate to the HomePage.
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(PreservingBottomNavBar.routeName);
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


  authenticateWithGoogle(UserProvider userProvider) async {

    try{
      final userCredential =  await signInWithGoogle();
      final userExists =
          await userProvider.doesUserExist(userCredential.user!.uid);
      if (!userExists) {
        EasyLoading.show(status: 'Redirecting user...');
        final userModel = UserModel(
          userId: userCredential.user!.uid,
          email: userCredential.user!.email!,
          userCreationTime: Timestamp.fromDate(DateTime.now()),
          displayName: userCredential.user!.displayName,
          imageUrl: userCredential.user!.photoURL,
          phone: userCredential.user!.phoneNumber,
        );
        await userProvider.addUser(userModel);
        EasyLoading.dismiss();
        if(mounted){
          showMsg(context, 'User Created Successfully');
        }
      }
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(PreservingBottomNavBar.routeName);
      }
    }catch (e) {
      EasyLoading.dismiss();
      rethrow;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
