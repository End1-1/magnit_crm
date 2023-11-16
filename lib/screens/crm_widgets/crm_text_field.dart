import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

crmPhoneField(TextEditingController controller, TextInputFormatter im, String label) {
  return Container(
      margin: const EdgeInsets.fromLTRB(2, 4, 2, 4),
      child: TextFormField(
        controller: controller,
        inputFormatters: [
          im
        ],
        decoration: InputDecoration(
          hintText: '+374 (77) 01-91-07',
            border: const OutlineInputBorder(),
            label: Text(label)),
      ));
}

crmTextField(TextEditingController controller, String label) {
  return Container(
      margin: const EdgeInsets.fromLTRB(2, 4, 2, 4),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
            label: Text(label)),
      ));
}

crmNumberTextField(TextEditingController controller, String label) {
  return Container(
      margin: const EdgeInsets.fromLTRB(2, 4, 2, 4),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(r'[0-9]'),
          ),
        ],
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            label: Text(label)),
      ));
}

crmPasswordField(TextEditingController controller, String label) {
  return Container(
      margin: const EdgeInsets.fromLTRB(2, 4, 2, 4),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            label: Text(label)),
      ));
}
