import 'package:flutter/material.dart';
import 'package:magnit_crm/screens/crm_app/screen.dart';
import 'package:magnit_crm/screens/crm_widgets/crm_image_button.dart';
import 'package:magnit_crm/screens/crm_widgets/crm_text.dart';
import 'package:magnit_crm/screens/crm_widgets/crm_text_field.dart';

import 'model.dart';

class ConfigScreen extends CrmApp {
  final ConfigScreenModel model;

  ConfigScreen({super.key, required this.model}) : super(m: model);

  @override
  List<Widget> body(BuildContext context) {
    return [
      crmTextField(model.serverController, model.tr('Server address')),
      //crmTextField(model.portController, model.tr('Server port')),
    ];
  }

  @override
  PreferredSize? appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Row(
          children: [
            crmImageButton(() {
              Navigator.pop(context);
            }, 'assets/icons/back.svg'),
            crmHeaderText(model.tr('Settings')),
            Expanded(child: Container()),
            crmImageButton(() {
              model.save(context);
            }, 'assets/icons/done.svg')
          ],
        ));
  }
}
