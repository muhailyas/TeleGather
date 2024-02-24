import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/core/responsive/responsive.dart';
import 'package:video_call_app/features/authentication/controller/authentication_controller.dart';
import 'package:video_call_app/features/authentication/view/login.dart';
import 'package:video_call_app/features/proflie/controller/image_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      ],
      child: MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
            )),
        debugShowCheckedModeBanner: false,
        title: 'TeleGather',
        home: const ScreenLogin(),
      ),
    );
  }
}
