import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/core/responsive/responsive.dart';
import 'package:video_call_app/core/theme/theme_provider.dart';
import 'package:video_call_app/features/authentication/controller/authentication_controller.dart';
import 'package:video_call_app/features/home/controller/home_controller.dart';
import 'package:video_call_app/features/home/controller/join_controller.dart';
import 'package:video_call_app/features/proflie/controller/profile_controller.dart';
import 'package:video_call_app/features/splash/controller/splash_controller.dart';
import 'package:video_call_app/features/splash/view/splash.dart';
import 'package:video_call_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationController>(
          create: (context) => AuthenticationController(),
        ),
        ChangeNotifierProvider<SplashController>(
          create: (context) => SplashController(),
        ),
        ChangeNotifierProvider<ProfileController>(
          create: (context) => ProfileController(),
        ),
        ChangeNotifierProvider<HomeController>(
          create: (context) => HomeController(),
        ),
        ChangeNotifierProvider<JoinWithCodeController>(
          create: (context) => JoinWithCodeController(),
        ),
        ChangeNotifierProvider<UiProvider>(
          create: (context) => UiProvider(),
        ),
      ],
      child: Consumer<UiProvider>(builder: (context, value, _) {
        value.init();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TeleGather',
          theme: value.isDark ? value.darkTheme : value.lightTheme,
          home: const ScreenSplash(),
        );
      }),
    );
  }
}
