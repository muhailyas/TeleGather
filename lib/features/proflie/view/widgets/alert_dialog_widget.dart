import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/features/authentication/controller/authentication_controller.dart';
import 'package:video_call_app/features/authentication/view/login.dart';
import 'package:video_call_app/features/proflie/view/widgets/custom_button.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      shape: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(15)),
      title: const Text("Logout", style: TextStyle(color: Colors.white)),
      content: const Text("Are you sure want to logout",
          style: TextStyle(color: Colors.white)),
      actions: [
        CustomButton(
            onPressed: () {
              context
                  .read<AuthenticationController>()
                  .logOut()
                  .then((value) => navigate(context, value));
            },
            child: const Text("Yes")),
        CustomButton(
            onPressed: () => Navigator.pop(context), child: const Text("No")),
      ],
    );
  }

  navigate(BuildContext context, String value) {
    if (value == 'navigate-to-login') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const ScreenLogin()),
          (route) => false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(value)));
    }
  }
}
