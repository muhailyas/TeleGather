import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/core/responsive/responsive.dart';
import 'package:video_call_app/features/authentication/view/login.dart';
import 'package:video_call_app/features/home/view/home.dart';
import 'package:video_call_app/features/splash/controller/splash_controller.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  ScreenSplashState createState() => ScreenSplashState();
}

class ScreenSplashState extends State<ScreenSplash>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        context
            .read<SplashController>()
            .checkUserExistenceAndNavigate()
            .then((value) => navigate(value, context));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: Responsive.height * 0.35,
            child: LottieBuilder.asset("assets/loading_animation.json"),
          ),
          FadeTransition(
            opacity: _animation,
            child: Text(
              "TeleGather",
              style: TextStyle(
                fontSize: Responsive.text * 30,
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

navigate(String value, BuildContext context) {
  if (value == 'navigate-to-home') {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const ScreenHome()));
  } else {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const ScreenLogin()));
  }
}
