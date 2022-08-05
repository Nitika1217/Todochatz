import 'package:flutter/material.dart';

class TextChatArea extends StatefulWidget {
  final TextEditingController _controller;
  final Function() callback;
  const TextChatArea(
    this._controller,
    this.callback, {
    Key? key,
  }) : super(key: key);

  @override
  State<TextChatArea> createState() => _TextChatAreaState();
}

class _TextChatAreaState extends State<TextChatArea> {
  bool isButtonActive = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextField(
              onChanged: (val) {
                if (val.length == 0) {
                  setState(() {
                    isButtonActive = false;
                  });
                } else {
                  setState(() {
                    isButtonActive = true;
                  });
                }
              },
              controller: widget._controller,
            ),
            flex: 9),
        Expanded(
          flex: 1,
          child: IconButton(
              onPressed: () async {
                setState(() {
                  isButtonActive = false;
                });
                await widget.callback();
                setState(() {
                  widget._controller.text = '';
                });
              },
              icon: Icon(Icons.send)),
        ),
      ],
    );
  }
}
