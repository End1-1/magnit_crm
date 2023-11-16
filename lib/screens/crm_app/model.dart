import 'dart:async';

import 'package:flutter/material.dart';
import 'package:magnit_crm/screens/login/model.dart';
import 'package:magnit_crm/screens/login/screen.dart';
import 'package:magnit_crm/utils/http_query.dart';
import 'package:magnit_crm/utils/keys.dart';
import 'package:magnit_crm/utils/prefs.dart';

abstract class CrmModel {
  final httpController = StreamController.broadcast();
  final loadingIndicatorController = StreamController();
  final dialogController = StreamController<String?>();
  Function? dialogOk;

  Future<T?> navigate<T>(Widget w, {bool clearStack = false}) {
    if (clearStack) {
      return Navigator.pushAndRemoveUntil(navigatorKey.currentContext!,
          MaterialPageRoute(builder: (builder) => w), (route) => false);
    } else {
      return Navigator.push(navigatorKey.currentContext!,
          MaterialPageRoute(builder: (builder) => w));
    }
  }

  String tr(String s) {
    return s;
  }

  void logout() {
    prefs.setString(pkLogin, '');
    prefs.setString(pkPassword, '');
    prefs.setBool(pkLoginRememberMe, false);
    navigate(LoginScreen(model: LoginScreenModel()), clearStack: true);
  }

  void dialogOkPressed() {
    dialogController.add(null);
    if (dialogOk != null) {
      dialogOk!();
    }
  }

  void httpOk(dynamic d) {

  }

  void httpError(dynamic d) {
    dialogController.add(d);
  }

  Future<void> httpQuery(Map<String, dynamic> params, {Function(dynamic)? okFunction}) async {
    loadingIndicatorController.add('Query in progress...');
    final result = await HttpQuery().request(params);
    loadingIndicatorController.add(null);
    if (result[kStatus] == hrOk) {
      if (okFunction == null) {
        httpOk(result['kData']);
      } else {
        okFunction(result['kData']);
      }
    } else {
      httpError(result['kData']);
    }
  }
}
