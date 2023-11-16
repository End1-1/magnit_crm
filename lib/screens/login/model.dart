import 'package:flutter/cupertino.dart';
import 'package:magnit_crm/screens/config/model.dart';
import 'package:magnit_crm/screens/config/screen.dart';
import 'package:magnit_crm/screens/crm_app/model.dart';
import 'package:magnit_crm/screens/dashboard/model.dart';
import 'package:magnit_crm/screens/dashboard/screen.dart';
import 'package:magnit_crm/utils/keys.dart';
import 'package:magnit_crm/utils/prefs.dart';

import 'data.dart';

class LoginScreenModel extends CrmModel {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  LoginScreenModel() {
    loginController.text = prefs.string(pkLogin);
    passwordController.text = prefs.string(pkPassword);
  }

  void selectMenu(int index) {
    switch (index) {
      case 1:
        navigate(ConfigScreen(model: ConfigScreenModel()));
        break;
    }
  }

  void loginRememberMe(bool v) {
    prefs.setBool(pkLoginRememberMe, v);
  }

  void login() async {
    Map<String, dynamic> params = {
      'call': 'sp_login_user_pass',
      'format': 1,
      'params': {
        'f_login': loginController.text,
        'f_password': passwordController.text
      }
    };
    await httpQuery(params);
  }

  @override
  void httpOk(dynamic d) {
    LoginData ld = LoginData.fromJson(d);
    prefs.setString(pkSession, ld.f_session);
    prefs.setInt(pkUserId, ld.f_user_id);
    if (prefs.loginRememberMe()) {
      prefs.setString(pkLogin, loginController.text);
      prefs.setString(pkPassword, passwordController.text);
    }
    navigate(DashboardScreen(model: DashboardScreenModel()), clearStack: true);
  }
}
