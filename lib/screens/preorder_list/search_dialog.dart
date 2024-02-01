import 'package:flutter/material.dart';
import 'package:magnit_crm/screens/crm_app/model.dart';
import 'package:magnit_crm/screens/crm_widgets/cmr_text_button.dart';
import 'package:magnit_crm/screens/crm_widgets/crm_text_field.dart';
import 'package:magnit_crm/utils/keys.dart';

class SearchDialog {
  final textController = TextEditingController();
  Future<String?> getInput(CrmModel model) async {
    return await showDialog(context: navigatorKey.currentContext!, builder: (context) {
      return SimpleDialog(
        contentPadding: const EdgeInsets.all(30),
        children: [
          Row(children: [
            Expanded(child: crmTextField(textController, model.tr('Text'), autofocus: true))
          ],),
          crmTextButton(model.tr('Search'), (){
            Navigator.pop(context, textController.text);
          })
        ],
      );
    });
  }
}