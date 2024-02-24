import 'package:flutter/material.dart';
import 'package:video_call_app/core/constants/constants.dart';
import 'package:video_call_app/features/home/view/call_page.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text("Enjoy with your friends",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            )),
      ),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final data = people[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(data['profile'].toString()),
              ),
              title: Text(
                data['name'].toString(),
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              trailing: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VideoConferencePage(
                              conferenceID: "erygiueygcmnbvqu4ruernygupiofupk",
                              userId: "erygiueygc597eutinghnrnygupiofupk",
                              userName: "Ilyas"),
                        ));
                  },
                  child: const Icon(Icons.videocam,
                      color: Colors.white, size: 25)),
            ),
          );
        },
      ),
    );
  }
}
