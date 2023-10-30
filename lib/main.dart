
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabbik_ui_clone/router.dart';
import 'package:kabbik_ui_clone/src/features/auth/screens/auth/auth_checking_page.dart';
import 'package:kabbik_ui_clone/src/features/core/controllers/audio_book_controller.dart';
import 'package:kabbik_ui_clone/src/features/core/controllers/audio_book_controller_firebase.dart';
import 'package:kabbik_ui_clone/src/services/notification_initialization.dart';
import 'package:kabbik_ui_clone/src/services/service_locator.dart';
import 'package:kabbik_ui_clone/src/utils/theme/theme.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  notificationInitialized();
  await setupServiceLocator();



  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AudioBookProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AudioBooksProviderFirebase(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Kabbik UI Clone',
        theme: KAppTheme.lightTheme,
        darkTheme: KAppTheme.dartTheme,
        themeMode: ThemeMode.system,
        builder: EasyLoading.init(),
        initialRoute: AuthCheckingPage.routeName,
        onGenerateRoute: (settings) {
          return AppRouter.generateRoute(settings);
        },
      ),
    );
  }
}

/*class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _appRouter.config(),
        title: 'Kabbik UI Clone',
        theme: KAppTheme.lightTheme,
        darkTheme: KAppTheme.dartTheme,
        themeMode: ThemeMode.system,
        builder: EasyLoading.init(),
      ),
    );
  }
}*/
