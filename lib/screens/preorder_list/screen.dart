import 'package:flutter/material.dart';
import 'package:magnit_crm/screens/crm_app/screen.dart';
import 'package:magnit_crm/screens/crm_widgets/crm_image_button.dart';
import 'package:magnit_crm/screens/crm_widgets/crm_text.dart';
import 'package:magnit_crm/utils/prefs.dart';

import 'data.dart';
import 'model.dart';

class PreorderListScreen extends CrmApp {
  final PreorderListScreenModel model;

  PreorderListScreen({super.key, required this.model}) : super(m: model);

  @override
  List<Widget> body(BuildContext context) {
    return [
      StreamBuilder(
          stream: model.bodyController.stream,
          builder: (builder, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            int row = 1;
            return Expanded(child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final e in snapshot.data) ...[
                      _preorderRow(context, e, row++),
                      const SizedBox(height: 10),
                    ]
                  ],
                ))));
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
            crmHeaderText(model.tr('List of preorders')),
            Expanded(child: Container()),
          ],
        ));
  }

  Widget _preorderRow(BuildContext context, Preorder p, int row) {
    return InkWell(onTap:(){
      model.openPreorder(p);
    }, child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        crmColumnText('$row', 30),
        crmColumnText(prefs.dateString(p.f_datefor), 80),
        crmColumnText(p.f_timefor, 60),
        crmColumnText(p.f_tablename, 60),
        crmColumnText(p.f_guestname, 200),
        crmColumnText(p.f_guestphone, 150)
      ],
    ));
  }
}
