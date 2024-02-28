import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/core/constants/constants.dart';
import 'package:video_call_app/core/responsive/responsive.dart';
import 'package:video_call_app/features/home/controller/home_controller.dart';
import 'package:video_call_app/features/home/view/join_with_code.dart';
import 'package:video_call_app/features/home/view/widgets/meeting_start_widget.dart';
import 'package:video_call_app/features/home/view/widgets/new_conference.dart';
import 'package:video_call_app/features/proflie/controller/profile_controller.dart';
import 'package:video_call_app/features/proflie/view/profile.dart';
import 'widgets/conference_list_widget.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileController>().getUserProfile();
    context.read<HomeController>().getConferences();
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => const NewConferenceBottomSheet());
                },
                child: MeetingStartWidget(
                    text: 'New meeting',
                    textColor: Theme.of(context).colorScheme.secondary)),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => ScreenJoinWithCode()));
              },
              child: MeetingStartWidget(
                text: 'Join with a code',
                border: true,
                textColor: Theme.of(context).colorScheme.secondary,
                backgroundColor: Theme.of(context).colorScheme.background,
              ),
            ),
          ],
        ),
        SizedBox(height: Responsive.height * 0.01),
        _buildConferenceItems()
      ],
    );
  }

  Expanded _buildConferenceItems() {
    return const Expanded(
      child: ConferenceListWidget(),
    );
  }

  PreferredSize _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(65),
      child: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text("TeleGather",
            style: TextStyle(
              fontSize: 22,
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w600,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScreenProfile()));
              },
              child: Consumer<ProfileController>(builder: (context, value, _) {
                return CircleAvatar(
                  backgroundImage: value.profileImage.isEmpty
                      ? const NetworkImage(placeHolderImage)
                      : NetworkImage(value.profileImage),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
