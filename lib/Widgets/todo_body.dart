import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todochatz/Controllers/notes.dart';
import 'package:todochatz/Pages/chatPage.dart';
import 'package:todochatz/Widgets/chat_text_Area.dart';

class Todobody extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Chatlist(), flex: 9),
        Expanded(
            child: TextChatArea(controller, () async {
          await notes.addnote(context, controller.text);
        }))
      ],
    );
  }
}

class Chatlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notes.Note,
      builder: (context, val, s2) {
        return notes.Note.value.length == 0
            ? Center(
                child: Text('Add a Note'),
              )
            : ListView(
                children: notes.Note.value
                    .map<Widget>((e) => ListTile(
                        leading: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.circle),
                          iconSize: 15,
                        ),
                        trailing: Text(e)))
                    .toList(),
              );
      },
    );
  }
}
