import 'package:flutter/material.dart';

Widget crmText(String text) {
  return Text(text, style: const TextStyle(color: Colors.black));
}

Widget crmColumnText(String text, double width) {
  return Container(
    margin: const EdgeInsets.fromLTRB(0, 5, 10, 5),
    width: width,
    child: crmText(text),
  );
}

Widget crmHeaderText(String text) {
  return Container(
      margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Align(
          alignment: Alignment.center,
          child: Text(text,
              maxLines: 10,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.deepPurple,
              ))));
}
