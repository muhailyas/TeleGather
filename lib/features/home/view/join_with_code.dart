import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/core/responsive/responsive.dart';
import 'package:video_call_app/features/authentication/view/widgets/text_field.dart';
import 'package:video_call_app/features/home/controller/home_controller.dart';
import 'package:video_call_app/features/home/controller/join_controller.dart';
import 'package:video_call_app/features/home/view/call_page.dart';
import 'package:video_call_app/features/proflie/controller/profile_controller.dart';

class ScreenJoinWithCode extends StatelessWidget {
  ScreenJoinWithCode({super.key});
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: const Text("Join with a code"),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: Responsive.height * 0.023,
              horizontal: Responsive.width * 0.05),
          child: Consumer<JoinWithCodeController>(builder: (context, value, _) {
            return InkWell(
              onTap: value.isValid
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoConferencePage(
                              conferenceID: codeController.text.trim(),
                              userId:
                                  context.read<ProfileController>().username,
                              userName:
                                  context.read<ProfileController>().username,
                            ),
                          ));
                    }
                  : null,
              child: Text(
                "Join",
                style: TextStyle(
                  fontSize: Responsive.text * 18,
                  fontWeight: value.isValid ? FontWeight.w500 : null,
                  color: value.isValid
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.grey,
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  Column _buildBody(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: Responsive.width * 0.03),
          child: Text("Enter the code provided by the conference organizer",
              style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
        ),
        SizedBox(height: Responsive.height * 0.02),
        TextFormFieldWidget(
            isJoinCode: true,
            controller: context.read<HomeController>().codeController,
            label: 'Enter your code'),
        SizedBox(height: Responsive.height * 0.02),
      ],
    );
  }
}
