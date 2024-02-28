import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/core/responsive/responsive.dart';
import 'package:video_call_app/features/proflie/controller/profile_controller.dart';
import 'package:video_call_app/features/proflie/view/widgets/custom_button.dart';

class UpdateUserNameWidget extends StatelessWidget {
  UpdateUserNameWidget({
    super.key,
    required this.text,
  });
  final String text;
  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    usernameController.text = text;
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(15)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Update username",
              style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(CupertinoIcons.clear_circled,
                color: Colors.red, weight: 10),
          )
        ],
      ),
      content: TextField(
        controller: usernameController,
        cursorColor: Theme.of(context).colorScheme.primary,
        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        decoration: InputDecoration(
            hintText: 'username',
            hintStyle:
                TextStyle(color: Theme.of(context).colorScheme.secondary),
            enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary))),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: Responsive.width * 0.05),
            Expanded(
              child: CustomButton(
                  onPressed: () {
                    if (usernameController.text.isNotEmpty) {
                      context.read<ProfileController>().updateUserName(
                          username: usernameController.text.trim());
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please fill with your username"),
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                  child: Text(
                    "Update",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  )),
            ),
            SizedBox(width: Responsive.width * 0.05),
          ],
        ),
      ],
    );
  }
}
