import 'package:flutter/material.dart';

class UserTextField extends StatelessWidget {
  const UserTextField(
      {required this.property,
      this.lines = 1,
      this.init = '',
      required this.controller,
      this.inputaction = TextInputAction.next,
      this.inputtype = TextInputType.text,
      this.textfieldsize = 0.8,
      super.key});
  final TextEditingController controller;
  final String property;
  final String init;
  final TextInputAction inputaction;
  final TextInputType inputtype;
  final int lines;
  final double textfieldsize;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * textfieldsize,
      child: TextFormField(
        controller: controller,
        maxLines: lines,
        keyboardType: inputtype,
        textInputAction: inputaction,
        initialValue: init,
        cursorColor: const Color.fromARGB(255, 255, 188, 3),
        style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 46, 41, 41)),
        decoration: InputDecoration(
            iconColor: const Color.fromARGB(255, 255, 188, 3),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 5.5, color: Color.fromARGB(255, 255, 188, 3))),
            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 104, 101, 101), width: 2.5)),
            labelText: property,
            labelStyle: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 66, 64, 64),
            )),
      ),
    );
  }
}
