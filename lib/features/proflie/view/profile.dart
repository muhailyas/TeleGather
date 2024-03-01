import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/core/constants/constants.dart';
import 'package:video_call_app/core/responsive/responsive.dart';
import 'package:video_call_app/core/theme/theme_provider.dart';
import 'package:video_call_app/features/proflie/controller/profile_controller.dart';
import 'package:video_call_app/features/proflie/view/widgets/alert_dialog_widget.dart';
import 'package:video_call_app/features/proflie/view/widgets/custom_button.dart';
import 'package:video_call_app/features/proflie/view/widgets/info_field_widget.dart';
import 'package:video_call_app/features/proflie/view/widgets/update_name_widget.dart';

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
        appBar: _buildAppBar(context),
        body: _buildBody(context, profileController),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ProfileController profileController) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: Responsive.width * 0.05),
            Column(
              children: [
                Consumer<ProfileController>(builder: (context, value, _) {
                  return Container(
                    height: Responsive.height * 0.115,
                    width: Responsive.height * 0.115,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
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
                  style: ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.secondary)),
                  child: const Text("Update image", style: TextStyle()),
                ),
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
          child: FittedBox(
            child: Text('Logout',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary)),
          ),
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
                  child: Icon(Icons.edit,
                      color: Theme.of(context).colorScheme.primary, size: 17))),
          SizedBox(height: Responsive.height * 0.012),
          InfoFieldWidget(text: value.email),
          SizedBox(height: Responsive.height * 0.012),
        ],
      );
    });
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back,
            color: Theme.of(context).colorScheme.secondary),
      ),
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text(
        "Profile",
        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
      ),
      actions: [
        Consumer<UiProvider>(builder: (context, value, _) {
          return Switch(
              activeTrackColor: value.isDark ? Colors.black : Colors.white,
              thumbColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.primary,
              ),
              trackColor: MaterialStatePropertyAll(
                  !value.isDark ? Colors.teal : Colors.white),
              value: value.isDark,
              onChanged: (data) {
                context.read<UiProvider>().changeTheme();
              });
        }),
        Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(Icons.help_outline_rounded,
                color: Theme.of(context).colorScheme.secondary)),
      ],
    );
  }
}
