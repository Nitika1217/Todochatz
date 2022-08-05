// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_import, camel_case_types, prefer_typing_uninitialized_variables, must_be_immutable, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todochatz/Controllers/message.dart';
import 'package:todochatz/Widgets/chat_text_Area.dart';
import 'package:todochatz/Widgets/chat_widget.dart';

class chatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').snapshots(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snap.hasError) {
          return Center(
            child: Text('An error has occured' + snap.error.toString()),
          );
        }
        final snapData = snap.data as QuerySnapshot;
        return chatRoom(message.mapDataToClass(snapData));
      },
    );
  }
}

class chatRoom extends StatelessWidget {
  final List<message> data;
  chatRoom(this.data);
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(data[0].text);
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) => Chatwidget(data[i])),
          flex: 9,
        ),
        Expanded(
            flex: 1,
            child: TextChatArea(this._controller, () async {
              try {
                FirebaseFirestore.instance.collection('chat').add({
                  'sender': FirebaseAuth.instance.currentUser!.uid,
                  'name': FirebaseAuth.instance.currentUser!.displayName,
                  'text': _controller.text
                });
              } catch (error) {
                print(error);
              }
            }))
      ],
    );
  }
}
