import 'dart:async';
import 'package:magnit_crm/screens/crm_app/model.dart';

class SelectDialogModel extends CrmModel {
  final String query;
  SelectDialogModel(this.query);
  List<Map<String, dynamic>> dataList = [];
  final listController = StreamController();

  @override
  void httpOk(dynamic d) {
    dataList.clear();
    dataList.addAll(List<Map<String,dynamic>>.from(d));
    listController.add(dataList);
  }

  @override
  Future<void> httpQuery(Map<String, dynamic> params, {Function(dynamic)? okFunction}) async {
    params = {
      'call':'sp_preorder_free_table',
      'format':2
    };
    super.httpQuery(params);
  }
}