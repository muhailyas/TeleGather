import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/core/responsive/responsive.dart';
import 'package:video_call_app/features/authentication/controller/authentication_controller.dart';
import 'package:video_call_app/features/authentication/view/sign_up.dart';
import 'package:video_call_app/features/home/view/home.dart';

import 'widgets/text_field.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationController>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: authProvider.loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: Responsive.width * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome to TeleGather",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: Responsive.height * 0.01),
                    const Text(
                      "Join the conversation, anytime, anywhere",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(height: Responsive.height * 0.01),
                  ],
                ),
              ),
              TextFormFieldWidget(
                controller: authProvider.usernameController,
                label: 'Email',
              ),
              SizedBox(height: Responsive.height * 0.02),
              TextFormFieldWidget(
                controller: authProvider.passwordController,
                label: 'Password',
              ),
              SizedBox(height: Responsive.height * 0.02),
              ElevatedButton(
                onPressed: () async {
                  if (authProvider.loginFormKey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenHome()));
                  }
                },
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                    fixedSize: MaterialStatePropertyAll(Size(
                        Responsive.width * 0.8, Responsive.height * 0.065)),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.white)),
                child: const Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: Responsive.height * 0.02),
              Align(
                  alignment: const Alignment(-0.65, 0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScreenSignUp()));
                    },
                    child: Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: Colors.teal.withOpacity(0.9).withRed(5)),
                    ),
                  )),
              SizedBox(height: Responsive.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
