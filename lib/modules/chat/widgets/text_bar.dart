import 'package:flutter/material.dart';

class TextBar extends StatefulWidget {
  TextBar({super.key, required this.sendmessage});

  Function(String) sendmessage;

  @override
  State<TextBar> createState() => _ChatBarState();
}

class _ChatBarState extends State<TextBar> {
  bool _isEnable = false;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt),
          ),
          Expanded(
            child: TextField(
              controller: textEditingController,
              onChanged: (text) {
                setState(() {
                  _isEnable = true;
                });
              },
              onSubmitted: (value) {
                widget.sendmessage(value);
                textEditingController.clear();
                setState(() {
                  _isEnable = false;
                });
              },
              decoration:
                  const InputDecoration.collapsed(hintText: "Digite algo"),
            ),
          ),
          if (_isEnable && textEditingController.text != "")
            IconButton(
              onPressed: () {
                widget.sendmessage(textEditingController.text);
                textEditingController.clear();
                setState(() {
                  _isEnable = false;
                });
              },
              icon: const Icon(Icons.send),
            )
        ],
      ),
    );
  }
}
