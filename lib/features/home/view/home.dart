import 'package:flutter/material.dart';
import 'package:video_call_app/core/constants/constants.dart';
import 'package:video_call_app/features/home/view/widgets/meeting_start_widget.dart';
import 'package:video_call_app/features/proflie/view/profile.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody());
  }

  Row _buildBody() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MeetingStartWidget(text: 'New meeting'),
        MeetingStartWidget(
          text: 'Join with a link',
          border: true,
          backgroundColor: Colors.black,
        ),
      ],
    );
  }

  PreferredSize _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(65),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text("TeleGather",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
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
              child: CircleAvatar(
                backgroundImage: NetworkImage(people[0]['profile'].toString()),
              ),
            ),
          )
        ],
      ),
    );
  }
}
