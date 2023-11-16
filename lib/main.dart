import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:magnit_crm/screens/login/model.dart';
import 'package:magnit_crm/screens/login/screen.dart';
import 'package:magnit_crm/utils/http_overrides.dart';
import 'package:magnit_crm/utils/keys.dart';
import 'package:magnit_crm/utils/prefs.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  HttpOverrides.global = MyHttpOverrides();

  prefs = await SharedPreferences.getInstance();
  PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    String appName = packageInfo.appName;
    //String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    prefs.setString(pkAppName, appName);
    prefs.setString(pkAppVersion, '$version.$buildNumber');
  });

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _App();
}

class _App extends State<App> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRM',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(model: LoginScreenModel()),
    );
  }

  void initialization() async {
    try {
      final result =
          await http.get(Uri.https('magnitsoft.com', '/crm/crm.json'));
      if (result.statusCode < 299) {
        Map<String, dynamic> json = jsonDecode(result.body);
        prefs.setString('serveraddress', json['server']);
      }
    } catch (e) {
      print(e);
    }
    FlutterNativeSplash.remove();
  }
}
