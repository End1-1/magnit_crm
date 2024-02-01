import 'dart:async';

import 'package:magnit_crm/screens/crm_app/model.dart';
import 'package:magnit_crm/screens/preorder/model.dart';
import 'package:magnit_crm/screens/preorder/screen.dart';
import 'package:magnit_crm/screens/preorder_list/search_dialog.dart';

import 'data.dart';

class PreorderListScreenModel extends CrmModel {
  final pl = <Preorder>[];
  final bodyController = StreamController();

  PreorderListScreenModel() {
    getList();
  }

  void openPreorder(Preorder p) {
    navigate(PreorderScreen(model: PreorderScreenModel(preorder: p)))
        .then((value) {
      if (value != null) {
        if (value) {
          getList();
        }
      }
    });
  }

  void httpOk(dynamic d) {
    pl.clear();
    for (final p in d) {
      pl.add(Preorder.fromJson(p));
    }
    bodyController.add(pl);
  }

  void getList() async {
    super.httpQuery({
      'call': 'sf_list_of',
      'format': 3,
      'params': {'list': 'preorders'}
    });
  }

  void searchDialog() {
    SearchDialog().getInput(this).then((value) {
      if (value != null) {
        super.httpQuery({
          'call': 'sf_list_of',
          'format': 3,
          'params': {'list': 'preorders', 'searchtext': value}
        });
      }
    });
  }
}
