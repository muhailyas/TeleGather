import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/app_info.dart';
import 'package:video_call_app/core/responsive/responsive.dart';
import 'package:video_call_app/features/home/controller/home_controller.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

ValueNotifier<bool> copyLinkVisibility = ValueNotifier(true);

class VideoConferencePage extends StatelessWidget {
  final String conferenceID;
  final String userId;
  final String userName;
  const VideoConferencePage({
    Key? key,
    required this.conferenceID,
    required this.userId,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ZegoUIKitPrebuiltVideoConference(
              appID: appIDZego,
              appSign: appSignZego,
              userID: userId,
              userName: userName,
              conferenceID: conferenceID,
              config: ZegoUIKitPrebuiltVideoConferenceConfig(),
            ),
            Positioned(
              left: Responsive.width * 0.05,
              bottom: Responsive.height * 0.13,
              child: ValueListenableBuilder(
                  valueListenable: copyLinkVisibility,
                  builder: (context, value, _) {
                    return GestureDetector(
                      onTap: () {
                        copyLinkVisibility.value = !copyLinkVisibility.value;
                      },
                      child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          width: Responsive.width * 0.3,
                          height: Responsive.height * 0.05,
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Copy link",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Responsive.text * 14,
                                ),
                              ),
                              SizedBox(width: Responsive.width * 0.04),
                              InkWell(
                                onTap: () {
                                  context
                                      .read<HomeController>()
                                      .copyToClipBoard(conferenceID)
                                      .then((value) => ScaffoldMessenger.of(
                                              context)
                                          .showSnackBar(
                                              SnackBar(content: Text(value))));
                                },
                                child: Icon(
                                  Icons.copy_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          )),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
