import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/core/responsive/responsive.dart';
import 'package:video_call_app/core/utils/utils.dart';
import 'package:video_call_app/features/authentication/controller/authentication_controller.dart';
import 'package:video_call_app/features/authentication/model/login_model.dart';
import 'package:video_call_app/features/authentication/view/sign_up.dart';
import 'package:video_call_app/features/authentication/view/widgets/elevated_button_widget.dart';
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
                    SizedBox(height: Responsive.height * 0.02),
                  ],
                ),
              ),
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
              Consumer<AuthenticationController>(builder: (context, value, _) {
                return ElevatedButtonWidget(
                    label: 'Login',
                    authProvider: authProvider,
                    onPressed: () {
                      if (authProvider.loginFormKey.currentState!.validate()) {
                        final loginModel = LoginModel(
                            email: authProvider.emailController.text.trim(),
                            password:
                                authProvider.passwordController.text.trim());
                        context
                            .read<AuthenticationController>()
                            .signWithEmailAndPassword(
                                loginModel: loginModel, context: context)
                            .then((value) {
                          showResult(value, context);
                          clearForm(authProvider);
                        });
                      }
                    });
              }),
              SizedBox(height: Responsive.height * 0.02),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ScreenSignUp()));
                },
                child: Text(
                  "Don't have an account?",
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
}

void clearForm(AuthenticationController controller) {
  controller.emailController.clear();
  controller.passwordController.clear();
  controller.confirmPasswordController.clear();
}
