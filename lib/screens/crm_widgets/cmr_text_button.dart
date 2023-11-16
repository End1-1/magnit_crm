import 'package:flutter/material.dart';

Widget crmTextButton(String text, VoidCallback f) {
  return TextButton(
      onPressed: f,
      child: Text(
        text,
        style: const TextStyle(),
      ));
}