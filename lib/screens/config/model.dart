import 'package:flutter/cupertino.dart';
import 'package:magnit_crm/screens/crm_app/model.dart';
import 'package:magnit_crm/utils/prefs.dart';

class ConfigScreenModel extends CrmModel {
  final serverController = TextEditingController();
  final portController = TextEditingController();

  ConfigScreenModel() {
    serverController.text = prefs.string('serveraddress');
  }

  void save(BuildContext context) {
    prefs.setString('serveraddress', serverController.text);
    prefs.setString('serverport', portController.text);
    Navigator.pop(context);
  }
}