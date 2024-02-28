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
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(15)),
      title: Text("Logout",
          style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
      content: Text("Are you sure want to logout",
          style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
      actions: [
        CustomButton(
            onPressed: () {
              context
                  .read<AuthenticationController>()
                  .logOut()
                  .then((value) => navigate(context, value));
            },
            child: Text(
              "Yes",
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            )),
        CustomButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "No",
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            )),
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
