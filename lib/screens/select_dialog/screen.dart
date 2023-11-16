import 'package:flutter/material.dart';
import 'package:magnit_crm/screens/crm_app/screen.dart';
import 'package:magnit_crm/screens/crm_widgets/crm_image_button.dart';
import 'package:magnit_crm/screens/crm_widgets/crm_text.dart';
import 'package:magnit_crm/screens/select_dialog/model.dart';

class SelectDialogScreen extends CrmApp {
  final SelectDialogModel model;
  final String title;
  final multiSelect;

  SelectDialogScreen(
      {super.key,
      required this.title,
      required this.model,
      this.multiSelect = false})
      : super(m: model) {
    model.httpQuery(<String, dynamic>{});
  }

  @override
  List<Widget> body(BuildContext context) {
    return [
      StreamBuilder(stream: model.listController.stream, builder: (builder, snapshot) {
        if (snapshot.hasData == false) {
          return Container();
        }
        return SingleChildScrollView(child: Column(
          children: [
            for(final m in snapshot.data!) ...[
            InkWell(onTap: (){
              Navigator.pop(context, m);
            },child: Row(
              children: [
                Expanded(child: Text(m['f_name']))
              ]))
          ]],
        ));
      })
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
            crmHeaderText(title),
            Expanded(child: Container()),
            crmImageButton(() {}, 'assets/icons/done.svg')
          ],
        ));
  }
}
