import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/core/responsive/responsive.dart';
import 'package:video_call_app/core/utils/utils.dart';
import 'package:video_call_app/features/authentication/controller/authentication_controller.dart';
import 'package:video_call_app/features/authentication/model/sign_up_model.dart';
import 'package:video_call_app/features/authentication/view/login.dart';
import 'package:video_call_app/features/authentication/view/widgets/elevated_button_widget.dart';
import 'package:video_call_app/features/authentication/view/widgets/text_field.dart';
import 'package:video_call_app/features/proflie/controller/profile_controller.dart';

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
                controller: authProvider.emailController,
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
              ElevatedButtonWidget(
                authProvider: authProvider,
                label: 'Create account',
                onPressed: () {
                  if (authProvider.signUpFormKey.currentState!.validate()) {
                    final signUpModel = SignUpModel(
                        email: authProvider.emailController.text.trim(),
                        password: authProvider.passwordController.text.trim(),
                        confirmPassword:
                            authProvider.confirmPasswordController.text.trim());
                    context
                        .read<AuthenticationController>()
                        .signUpWithEmailAndPassword(
                            signUpModel: signUpModel, context: context)
                        .then((value) {
                      showResult(value, context);
                      createAccount(context, value);
                      clearForm(authProvider, value);
                    });
                  }
                },
              ),
              SizedBox(height: Responsive.height * 0.02),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ScreenLogin()));
                },
                child: Text(
                  "Already have an account?",
                  style:
                      TextStyle(color: Colors.teal.withOpacity(0.9).withRed(5)),
                ),
              ),
              SizedBox(height: Responsive.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  void createAccount(BuildContext context, String value) {
    if (value != 'navigate-to-login') {
      return;
    }
    context.read<ProfileController>().createProfile();
  }
}
