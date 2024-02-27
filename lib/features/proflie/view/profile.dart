import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/core/constants/constants.dart';
import 'package:video_call_app/core/responsive/responsive.dart';
import 'package:video_call_app/features/proflie/controller/profile_controller.dart';
import 'package:video_call_app/features/proflie/view/widgets/alert_dialog_widget.dart';
import 'package:video_call_app/features/proflie/view/widgets/custom_button.dart';
import 'package:video_call_app/features/proflie/view/widgets/info_field_widget.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context);
    profileController.getUserProfile();
    return WillPopScope(
      onWillPop: () async {
        context.read<ProfileController>().getUserProfile();
        return true;
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(context, profileController),
      ),
    );
  }

  Column _buildBody(BuildContext context, ProfileController profileController) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 20),
            Column(
              children: [
                Consumer<ProfileController>(builder: (context, value, _) {
                  return Container(
                    height: Responsive.height * 0.115,
                    width: Responsive.height * 0.115,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        shape: BoxShape.circle,
                        image: value.profileImage.isNotEmpty
                            ? value.profileImage.contains("https")
                                ? DecorationImage(
                                    image: NetworkImage(value.profileImage),
                                    fit: BoxFit.cover)
                                : DecorationImage(
                                    image: FileImage(File(value.profileImage)),
                                    fit: BoxFit.cover)
                            : const DecorationImage(
                                image: NetworkImage(placeHolderImage),
                                fit: BoxFit.cover)),
                  );
                }),
                TextButton(
                  onPressed: () {
                    profileController.updateImageLocal();
                  },
                  style: const ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(Colors.white)),
                  child: const Text("Update image"),
                )
              ],
            ),
            SizedBox(width: Responsive.width * 0.02),
            _buildInfoFields(context)
          ],
        ),
        const Spacer(),
        CustomButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialogWidget();
              },
            );
          },
          child: const Text('Logout'),
        )
      ],
    );
  }

  Widget _buildInfoFields(BuildContext context) {
    return Consumer<ProfileController>(builder: (_, value, __) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Responsive.height * 0.007),
          InfoFieldWidget(
              text: value.username.isEmpty ? 'No username' : value.username,
              trailing: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          UpdateUserNameWidget(text: value.username),
                    );
                  },
                  child: const Icon(Icons.edit, color: Colors.teal, size: 17))),
          SizedBox(height: Responsive.height * 0.012),
          InfoFieldWidget(text: value.email),
          SizedBox(height: Responsive.height * 0.012),
        ],
      );
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Profile"),
      actions: const [
        Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.help_outline_rounded))
      ],
    );
  }
}

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
      backgroundColor: Colors.black,
      shape: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(15)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Update username", style: TextStyle(color: Colors.white)),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(CupertinoIcons.clear_circled,
                color: Colors.red, weight: 10),
          )
        ],
      ),
      content: TextField(
        controller: usernameController,
        cursorColor: Colors.teal,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
            hintText: 'username',
            hintStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.teal))),
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
                  child: const Text("Update")),
            ),
            SizedBox(width: Responsive.width * 0.05),
          ],
        ),
      ],
    );
  }
}
