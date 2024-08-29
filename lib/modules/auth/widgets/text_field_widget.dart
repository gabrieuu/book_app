import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({super.key, this.controller, required this.validator, this.hintText, this.boxColor, this.hintStyle, this.border, this.erroMessage = ''});

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final Color? boxColor;
  final TextStyle? hintStyle;
  final InputBorder? border;
  final String erroMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: boxColor ??Colors.grey[300],
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextFormField(
            validator: validator,
              controller: controller,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: hintStyle ?? const TextStyle(color: Colors.black45),
              border: border ?? const OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
        (erroMessage.isNotEmpty)
          ? Padding(
            padding: const EdgeInsets.only(left: 10, top: 3),
            child: Text(
                erroMessage,
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 13),
              ),
          )
          : const SizedBox()
      ],
    );
  }
}
