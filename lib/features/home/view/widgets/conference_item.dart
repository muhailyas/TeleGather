import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/core/responsive/responsive.dart';
import 'package:video_call_app/features/home/controller/home_controller.dart';
import 'package:video_call_app/features/home/model/conference_model.dart';
import 'package:video_call_app/features/home/view/call_page.dart';
import 'package:video_call_app/features/proflie/controller/profile_controller.dart';

class ConferenceItemContainer extends StatelessWidget {
  ConferenceItemContainer({
    Key? key,
    required this.index,
    required this.conferenceModel,
  }) : super(key: key);

  final int index;
  final ConferenceModel conferenceModel;
  final ValueNotifier<bool> isDeleting = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.width * 0.03,
        vertical: Responsive.height * 0.01,
      ),
      child: InkWell(
        onDoubleTap: () {
          isDeleting.value = !isDeleting.value;
        },
        child: Container(
          height: Responsive.height * 0.05,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.height * 0.02,
              vertical: Responsive.width * 0.032,
            ),
            child: Row(
              children: [
                Text(
                  conferenceModel.conferenceId.substring(0, 20),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    // join to the conference
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoConferencePage(
                          conferenceID: conferenceModel.conferenceId,
                          userId: conferenceModel.userId,
                          userName: context.read<ProfileController>().username,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Join",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
                SizedBox(width: Responsive.width * 0.05),
                InkWell(
                  onTap: () {
                    // copy the link
                    context
                        .read<HomeController>()
                        .copyToClipBoard(conferenceModel.conferenceId)
                        .then((value) => ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(value))));
                  },
                  child: Text(
                    "Copy",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
                ValueListenableBuilder(
                    valueListenable: isDeleting,
                    builder: (context, value, _) {
                      return value
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: Responsive.width * 0.05),
                              child: Consumer<HomeController>(
                                builder: (context, value, child) {
                                  return value.deleteLoading
                                      ? SizedBox(
                                          height: Responsive.width * 0.04,
                                          width: Responsive.width * 0.04,
                                          child: CircularProgressIndicator(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            context
                                                .read<HomeController>()
                                                .deleteConference(
                                                    conferenceModel
                                                        .conferenceId);
                                          },
                                          child: Text("Delete",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary)),
                                        );
                                },
                              ),
                            )
                          : const SizedBox();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
