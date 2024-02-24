import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/core/responsive/responsive.dart';
import 'package:video_call_app/features/authentication/controller/authentication_controller.dart';
import 'package:video_call_app/features/authentication/view/login.dart';
import 'package:video_call_app/features/authentication/view/widgets/text_field.dart';

class ScreenSignUp extends StatelessWidget {
  const ScreenSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationController>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: authProvider.signUpFormKey,
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
                      "Join TeleGather Today",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: Responsive.height * 0.01),
                    const Text(
                      "Experience seamless video conferencing",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Responsive.height * 0.02),
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
              TextFormFieldWidget(
                controller: authProvider.confirmPasswordController,
                label: 'Confirm Password',
              ),
              SizedBox(height: Responsive.height * 0.02),
              ElevatedButton(
                onPressed: () async {
                  if (authProvider.signUpFormKey.currentState!.validate()) {}
                },
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                    fixedSize: MaterialStatePropertyAll(Size(
                        Responsive.width * 0.8, Responsive.height * 0.065)),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.white)),
                child: Text(
                  "Create account",
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: Responsive.text * 20,
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
                              builder: (context) => const ScreenLogin()));
                    },
                    child: Text(
                      "Already have an account?",
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
