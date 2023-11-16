import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:magnit_crm/utils/prefs.dart';

import 'keys.dart';

class HttpQuery {
  Future<Map<String, dynamic>> request(Map<String, Object?> inData) async {
    Map<String, Object?> outData = {};
    String strBody = jsonEncode(inData);
    if (kDebugMode) {
      print('request: $strBody');
    }
    try {
      var response = await http
          .post(
              Uri.https(
                  '${prefs.getString('serveraddress')}',
                  '/remotedb'),
              headers: {
                'Content-Type': 'application/json',
                //'Content-Length': '${utf8.encode(strBody).length}'
                // "Access-Control-Allow-Origin": "*",
                // "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
                // "Access-Control-Allow-Headers":
                //     "Origin, X-Requested-With, Content-Type, Accept"
              },
              body: utf8.encode(strBody))
          .timeout(const Duration(seconds: 25), onTimeout: () {
        return http.Response('Timeout', 408);
      });
      String strResponse = utf8.decode(response.bodyBytes);
      if (kDebugMode) {
        print('Row body $strResponse');
      }
      if (response.statusCode < 299) {
        try {
          outData = jsonDecode(strResponse);
        } catch (e) {
          outData[kStatus] = hrFail;
          outData[kData] = '${e.toString()} $strResponse';
        }
      } else {
        outData[kStatus] = hrFail;
        outData[kData] = strResponse;
      }
    } catch (e) {
      outData[kStatus] = hrNetworkError;
      outData[kData] = e.toString();
    }
    if (kDebugMode) {
      print('Output $outData');
    }
    return outData;
  }
}
