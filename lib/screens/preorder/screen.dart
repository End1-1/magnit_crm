import 'package:flutter/material.dart';
import 'package:magnit_crm/screens/crm_app/screen.dart';
import 'package:magnit_crm/screens/crm_widgets/crm_image_button.dart';
import 'package:magnit_crm/screens/crm_widgets/crm_text.dart';
import 'package:magnit_crm/screens/crm_widgets/crm_text_field.dart';

import 'model.dart';

class PreorderScreen extends CrmApp {
  final PreorderScreenModel model;

  PreorderScreen({super.key, required this.model}) : super(m: model);

  @override
  List<Widget> body(BuildContext context) {
    return [
      Row(children: [
        Expanded(child: crmTextField(model.tableController, model.tr('Table'))),
        crmImageButton(model.selectTable, 'assets/icons/edit.svg')
      ],),
      Row(children: [
        Expanded(child: crmTextField(model.dateController, model.tr('Date'))),
        crmImageButton(model.selectDate, 'assets/icons/edit.svg')
      ]),
      Row(
        children: [
          Expanded(child: crmTextField(model.timeController, model.tr('Time'))),
          crmImageButton(model.selectTime, 'assets/icons/edit.svg')
        ],
      ),
      crmPhoneField(model.phoneController, model.phoneMaskFormatter, model.tr('Phone number')),
      crmTextField(model.guestController, model.tr('Guest name')),
      crmTextField(model.emailController, model.tr('Email')),
      crmNumberTextField(model.guestCountController, model.tr('Count of guests')),
      crmNumberTextField(model.amountController, model.tr('Prepaid amount')),
      crmTextField(model.commentController, model.tr('Comment')),
      crmTextField(model.feedbackController, model.tr('Feedback')),
    ];
  }

  @override
  PreferredSize? appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            crmImageButton(() {
              Navigator.pop(context);
            }, 'assets/icons/back.svg'),
            crmHeaderText(model.tr('Preorder info')),
            Expanded(child: Container()),
            crmImageButton(model.save, 'assets/icons/done.svg')
          ],
        ));
  }
}
