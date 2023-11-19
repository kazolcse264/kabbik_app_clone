import 'package:flutter/material.dart';
import 'package:kabbik_ui_clone/src/features/auth/screens/auth/auth_checking_page.dart';
import 'package:kabbik_ui_clone/src/features/auth/screens/reset_password/reset_password_page.dart';
import 'package:kabbik_ui_clone/src/features/auth/screens/sign_in/sign_in_page.dart';
import 'package:kabbik_ui_clone/src/features/auth/screens/sign_up/sign_up_page.dart';
import 'package:kabbik_ui_clone/src/features/core/models/audio_book.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/add_audio_screen/add_audio_book.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/audio_book_details_page/details_page.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/audio_playing_screen/playing_screen.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/dashboard/home_page.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/dashboard/preserving_bottom_nav_bar.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/user_profile_screen/otp_verification_page.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/user_profile_screen/user_profile_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AuthCheckingPage.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const AuthCheckingPage(),
        );

      case ResetPasswordPage.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const ResetPasswordPage(),
        );
      case PreservingBottomNavBar.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const PreservingBottomNavBar(),
        );
      case AddAudioBookPage.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const AddAudioBookPage(),
        );

      case DetailsPage.routeName:
        var audioBook = routeSettings.arguments as AudioBookF;
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => DetailsPage(
            audioBook: audioBook,
          ),
        );
      case HomePage.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const HomePage(),
        );
      case PlayingScreen.routeName:
        var audioBook = routeSettings.arguments as AudioBookF;
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => PlayingScreen(
            audioBook: audioBook,
          ),
        );
      case SignInPage.routeName:
        var voidCallback = routeSettings.arguments as VoidCallback;
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SignInPage(
            onClickedSignUp: voidCallback,
          ),
        );
      case SignUpPage.routeName:
        var function = routeSettings.arguments as Function();
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SignUpPage(
            onClickedSignIn: function,
          ),
        );

      case OtpVerificationPage.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const OtpVerificationPage(),
        );

      case UserProfileScreen.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const UserProfileScreen(),
        );
      default:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
            backgroundColor: Colors.red,
            body: Center(
              child: Text(
                'Screen does not exist!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        );
    }
  }
}
