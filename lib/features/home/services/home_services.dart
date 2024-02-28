import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:video_call_app/features/home/model/video_conference_model.dart';

class HomeServices {
  final _firebase = FirebaseFirestore.instance;
  Future<Either<VideoConferenceModel, String>> startQuickConference() async {
    const uuid = Uuid();
    final conferenceId = uuid.v4();
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    try {
      final userDocument =
          await _firebase.collection('Users').doc(currentUserId).get();
      if (userDocument.exists) {
        final userName = userDocument.data()!['username'];
        final userId = userDocument.data()!['id'];
        final videoConferenceModel = VideoConferenceModel(
          conferenceId: conferenceId,
          userName: userName,
          userId: userId,
        );
        await createConfereferenceId(conferenceId);
        return left(videoConferenceModel);
      } else {
        return right('user not found');
      }
    } catch (e) {
      return right(e.toString());
    }
  }

  copyToClipBoard(String text) async {
    Clipboard.setData(ClipboardData(text: text));
    return 'Code copied';
  }

  Future<List<Map<String, dynamic>>> getConferences() async {
    final conferences = await _firebase
        .collection('conferences')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    return conferences.docs.map((e) => e.data()).toList();
  }

  createConfereferenceId(String id) async {
    await _firebase.collection('conferences').doc().set({
      'ids': id,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  deleteConfereferenceId(String conferenceId) async {
    try {
      // Get a reference to the conference collection
      CollectionReference collection = _firebase.collection('conferences');
      // Query the documents that match the conferenceId
      Query query = collection.where('ids', isEqualTo: conferenceId);
      // Get the documents from the query
      QuerySnapshot querySnapshot = await query.get();
      // Loop through the documents and delete them
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      // print('Documents deleted successfully');
    } catch (e) {
      // print('Error deleting documents: $e');
    }
  }

  Future<bool> validateJoinCode(String value) async {
    final result = await _firebase
        .collection('conferences')
        .where('ids', isEqualTo: value)
        .get();
    return result.docs.isNotEmpty;
  }

  Future<String> getConferenceLinkToLink() async {
    const uuid = Uuid();
    final conferenceId = uuid.v4();
    await createConfereferenceId(conferenceId);
    return conferenceId;
  }
}
