import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget crmBigButton(VoidCallback callback, String icon, String text) {
  return Container(margin: const EdgeInsets.all(2), child: OutlinedButton.icon(onPressed: callback,
    style: OutlinedButton.styleFrom(
      fixedSize: Size(300, 60),
      padding: const EdgeInsets.fromLTRB(4, 4, 10, 4),
      shape: RoundedRectangleBorder(side: const BorderSide(), borderRadius: BorderRadius.circular(4))
    ),    
      icon: SvgPicture.asset(icon, height: 48,), label: Text(text)));
}