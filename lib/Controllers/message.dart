import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class message {
  String? text;
  bool? isSentByMe;
  String displayName;

  message(this.text, this.isSentByMe, this.displayName);
  static final List<message> messages = [];

  static List<message> mapDataToClass(QuerySnapshot data) {
    for (var d in data.docChanges) {
      messages.add(message(
          d.doc['text'],
          d.doc['sender'] == FirebaseAuth.instance.currentUser!.uid
              ? true
              : false,
          d.doc['name'].toString()));
    }
    return messages;
  }
}
