import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/core/constants/constants.dart';
import 'package:video_call_app/core/responsive/responsive.dart';
import 'package:video_call_app/features/proflie/controller/image_controller.dart';
import 'package:video_call_app/features/proflie/view/widgets/info_field_widget.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final imageController = Provider.of<ImageController>(context);
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context, imageController),
    );
  }

  Column _buildBody(BuildContext context, ImageController imageController) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 20),
            Column(
              children: [
                Consumer<ImageController>(builder: (context, value, _) {
                  return Container(
                    height: Responsive.height * 0.115,
                    width: Responsive.height * 0.115,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        shape: BoxShape.circle,
                        image: value.profileImage.isNotEmpty
                            ? DecorationImage(
                                image: FileImage(File(value.profileImage)),
                                fit: BoxFit.cover)
                            : DecorationImage(
                                image: NetworkImage(
                                    people[0]['profile'].toString()),
                                fit: BoxFit.cover)),
                  );
                }),
                TextButton(
                  onPressed: () {
                    imageController.updateImage();
                  },
                  style: const ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(Colors.white)),
                  child: const Text("Update image"),
                )
              ],
            ),
            SizedBox(width: Responsive.width * 0.02),
            _buildInfoFields()
          ],
        ),
      ],
    );
  }

  Column _buildInfoFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Responsive.height * 0.007),
        const InfoFieldWidget(
            text: 'Anu',
            trailing: Icon(Icons.edit, color: Colors.teal, size: 17)),
        SizedBox(height: Responsive.height * 0.012),
        const InfoFieldWidget(text: 'Anu@gmail.com'),
        SizedBox(height: Responsive.height * 0.012),
      ],
    );
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
