import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masked_text_field/masked_text_field.dart';

import 'crm_text.dart';

crmPhoneField(TextEditingController controller, String label) {
  return Container(
      margin: const EdgeInsets.fromLTRB(2, 4, 2, 4),
      child: MaskedTextField(
        mask: 'xx xx-xx-xx',
        textFieldController: controller,
        onChange: (v) {

        },
        inputDecoration: InputDecoration(
            prefix: crmText('+374'),
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
