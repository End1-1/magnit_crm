import 'package:flutter/material.dart';
import 'package:magnit_crm/screens/crm_app/screen.dart';
import 'package:magnit_crm/screens/crm_widgets/cmr_text_button.dart';
import 'package:magnit_crm/screens/crm_widgets/crm_checkbox.dart';
import 'package:magnit_crm/screens/crm_widgets/crm_text.dart';
import 'package:magnit_crm/screens/crm_widgets/crm_text_field.dart';
import 'package:magnit_crm/screens/login/model.dart';
import 'package:magnit_crm/utils/keys.dart';
import 'package:magnit_crm/utils/prefs.dart';

class LoginScreen extends CrmApp {
  final LoginScreenModel model;

  LoginScreen({super.key, required this.model}) : super(m: model);

  @override
  List<Widget> body(BuildContext context) {
    if (prefs.loginRememberMe()) {
      model.login();
    }
    return [
      crmTextField(model.loginController, model.tr('Username')),
      crmPasswordField(model.passwordController, model.tr('Password')),
      StreamBuilder(
          stream: model.httpController.stream,
          builder: (builder, snapshot) {
            return Row(
              children: [
                CrmCheckbox(prefs.loginRememberMe(), model.loginRememberMe),
                crmText(model.tr('Remember me')),
                Expanded(child: Container()),
                crmTextButton(model.tr('Login'), model.login)
              ],
            );
          }),
      Expanded(flex: 1, child: Container()),
      crmText(prefs.string(pkAppVersion))
    ];
  }

  @override
  PreferredSize? appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight), child: Row(children: [
      crmHeaderText(prefs.appName()),
          Expanded(child: Container()),
          PopupMenuButton<int>(
              onSelected: (index) {
                model.selectMenu(index);
              },
              itemBuilder: (itemBuilder) {
        return [
          PopupMenuItem(value: 1,child: Text(model.tr('Settings')),)
        ] ;
    })
    ],));
  }
}
