import 'package:flutter/material.dart';

ButtonStyle signInButtonStyle({Color backgroundColor = Colors.red}) {
  return OutlinedButton.styleFrom(
      padding: const EdgeInsets.all(16),
      minimumSize: const Size(500, 56),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      backgroundColor: backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ));
}

InputDecoration signInTextFieldDecoration() {
  return const InputDecoration(
    contentPadding: EdgeInsets.all(18),
    border:
        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
  );
}

const SizedBox vertical16 = SizedBox(height: 16);
const SizedBox vertical8 = SizedBox(height: 16);
