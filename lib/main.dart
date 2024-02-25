import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/core/responsive/responsive.dart';
import 'package:video_call_app/features/authentication/controller/authentication_controller.dart';
import 'package:video_call_app/features/proflie/controller/image_controller.dart';
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
        ChangeNotifierProvider<ImageController>(
          create: (context) => ImageController(),
        ),
        ChangeNotifierProvider<AuthenticationController>(
          create: (context) => AuthenticationController(),
        ),
        ChangeNotifierProvider<SplashController>(
          create: (context) => SplashController(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
            )),
        debugShowCheckedModeBanner: false,
        title: 'TeleGather',
        home: const ScreenSplash(),
      ),
    );
  }
}
