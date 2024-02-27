import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/features/home/controller/home_controller.dart';
import 'package:video_call_app/features/home/view/widgets/conference_item.dart';

class ConferenceListWidget extends StatelessWidget {
  const ConferenceListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, value, _) {
      return ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: ListView.builder(
          itemCount: value.conferences.length,
          itemBuilder: (context, index) => ConferenceItemContainer(
              index: index, conferenceModel: value.conferences[index]),
        ),
      );
    });
  }
}
