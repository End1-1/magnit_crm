import 'package:flutter/material.dart';
import 'package:magnit_crm/screens/crm_app/screen.dart';
import 'package:magnit_crm/screens/crm_widgets/crm_image_button.dart';
import 'package:magnit_crm/screens/crm_widgets/crm_text.dart';
import 'package:magnit_crm/screens/crm_widgets/crm_text_field.dart';
import 'package:flutter/services.dart';
import 'model.dart';

class PreorderScreen extends CrmApp {
  final PreorderScreenModel model;

  PreorderScreen({super.key, required this.model}) : super(m: model);

  @override
  List<Widget> body(BuildContext context) {
    return [
      Expanded(child: SingleChildScrollView(child: Column(children:[
        Row(
          children: [InkWell(onTap: (){Clipboard.setData(ClipboardData(text: model.preorder?.f_id ?? '' )); }, child:  crmColumnText(model.preorder?.f_id ?? '', 320))],
        ),
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
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Expanded(child: crmPhoneField(model.phoneController, model.tr('Phone number'))),
        crmImageButton(model.findInfo, 'assets/icons/search.svg')
      ],),
      crmTextField(model.guestController, model.tr('Guest name')),
      crmTextField(model.emailController, model.tr('Email')),
      crmNumberTextField(model.guestCountController, model.tr('Count of guests')),
      crmNumberTextField(model.amountCashController, model.tr('Prepaid cash amount')),
      crmNumberTextField(model.amountCardController, model.tr('Prepaid card amount')),
      crmTextField(model.commentController, model.tr('Comment')),
      crmTextField(model.feedbackController, model.tr('Feedback'))]))),
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
            crmImageButton(model.delete, 'assets/icons/delete.svg'),
            crmImageButton(model.save, 'assets/icons/done.svg')
          ],
        ));
  }
}
