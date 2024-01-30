import 'package:flutter/material.dart';
import 'package:magnit_crm/screens/crm_app/screen.dart';
import 'package:magnit_crm/screens/crm_widgets/crm_big_button.dart';
import 'package:magnit_crm/screens/crm_widgets/crm_text.dart';
import 'package:magnit_crm/screens/preorder/model.dart';
import 'package:magnit_crm/screens/preorder/screen.dart';
import 'package:magnit_crm/screens/preorder_list/model.dart';
import 'package:magnit_crm/screens/preorder_list/screen.dart';

import 'model.dart';

class DashboardScreen extends CrmApp {
  final DashboardScreenModel model;

  DashboardScreen({super.key, required this.model}) : super(m: model);

  @override
  List<Widget> body(BuildContext context) {
    return [
      Row(children:[crmBigButton(() {
        model.navigate(PreorderScreen(model: PreorderScreenModel()));
      }, 'assets/icons/preorder.svg', model.tr('Create preorder'))]),
      Row(children:[crmBigButton(() {
        model.navigate(PreorderListScreen(model: PreorderListScreenModel()));
      }, 'assets/icons/preorder.svg', model.tr('List of preorders'))])
    ];
  }

  @override
  PreferredSize? appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            crmHeaderText(model.tr('Dashboard')),
            Expanded(child: Container()),
            PopupMenuButton<int>(
                onSelected: (index) {
                  model.logout();
                },
                itemBuilder: (itemBuilder) {
                  return [
                    PopupMenuItem(
                      value: 1,
                      child: Text(model.tr('Logout')),
                    )
                  ];
                })
          ],
        ));
  }
}
