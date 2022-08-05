// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:todochatz/Controllers/message.dart';

class Chatwidget extends StatelessWidget {
  final message data;
  Chatwidget(this.data);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          !data.isSentByMe! ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          padding: EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: !data.isSentByMe! ? Colors.grey : Colors.green),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (!data.isSentByMe! && data.displayName != null)
              Container(
                  child: Text(
                data.displayName,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            Container(
              child: Text(data.text!),
            ),
          ]),
        )
      ],
    );
  }
}
