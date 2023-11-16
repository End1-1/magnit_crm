import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget crmImageButton(VoidCallback callback, String asset) {
  return Container(margin: const EdgeInsets.fromLTRB(3, 3, 3, 3), child: InkWell(onTap: callback,
  child: SvgPicture.asset(asset, height: 32,)));
}