import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'keys.dart';

extension CrmSharedPreferences on SharedPreferences {

  String string(String key) {
    return getString(key) ?? '';
  }

  String dateString(String s) {
    return DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse(s));
  }

  String appName() {
    return 'CRM CVIEW';
  }

  bool loginRememberMe() {
    return getBool(pkLoginRememberMe) ?? false;
  }

  String session() {
    if (getString(pkSession) == null) {
      renewSession();
    }
    return getString(pkSession)!;
  }

  void renewSession() {
    setString(pkSession, const Uuid().v1());
  }
}

late SharedPreferences prefs;
