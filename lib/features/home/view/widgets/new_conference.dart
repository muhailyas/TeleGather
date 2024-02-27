import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/core/responsive/responsive.dart';
import 'package:video_call_app/features/home/controller/home_controller.dart';
import 'package:video_call_app/features/home/view/call_page.dart';

class NewConferenceBottomSheet extends StatelessWidget {
  const NewConferenceBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      height: Responsive.height * 0.16,
      child: Consumer<HomeController>(builder: (context, data, _) {
        return Column(
          children: [
            ListTile(
              onTap: () {
                context
                    .read<HomeController>()
                    .startQuickConference()
                    .then((value) => result(value, context, data));
              },
              leading:
                  const Icon(Icons.video_call_rounded, color: Colors.white),
              title: const Text(
                "Start a quick conference",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Divider(color: Colors.white, thickness: 1),
            ListTile(
              onTap: () {
                context.read<HomeController>().getConferenceLinkToLink();
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.teal,
                      title: Text(
                        "Here's the code to your conference",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Responsive.text * 16,
                        ),
                      ),
                      content: Text(
                        "Copy this code and send it to people you want to meet with. Be sure to save it so you can use it later,too.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Responsive.text * 16,
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            width: Responsive.width,
                            height: Responsive.height * 0.06,
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: Responsive.width * 0.5,
                                    child: Text(
                                      data.instantId,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const Icon(Icons.copy_outlined,
                                      color: Colors.white)
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              },
              leading: const Icon(Icons.share, color: Colors.white),
              title: const Text(
                "Get a conference link to share",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      }),
    );
  }

  result(String value, BuildContext context, HomeController data) {
    if ('navigate-to-conference' == value) {
      final conferenceId = data.videoConferenceInfo!.conferenceId;
      final userId = data.videoConferenceInfo!.userId;
      final username = data.videoConferenceInfo!.userName;
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoConferencePage(
                conferenceID: conferenceId, userId: userId, userName: username),
          ));
      context.read<HomeController>().getConferences();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(value)));
    }
  }
}
