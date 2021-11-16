import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:UEnicsERP/ui/base/ActivityResult.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import '../../main.dart';
import '../local/prefs/AppPreferencesHelper.dart';
import '../models/default_response.dart';
import 'package:http/http.dart' as http;

enum ErrorType { NONE, OK, APP_OUTDATED, SESSION_TIMEOUT, RETRY }

class Webservice {
  late BuildContext _buildContext;
  Future? dialog = null;
  String? updatedToken = null;

  set buildContext(BuildContext value) {
    _buildContext = value;
  }

  //staging
  static String BASE_HOST_URL = "https://uenics-erp.herokuapp.com";

  //development
  // static String BASE_HOST_URL = "http://127.0.0.1:5000";

  //production
  //static final String BASE_HOST_URL = "http://staging.praman.ai" ;
  static String BASE_URL = BASE_HOST_URL + "/";

  Future<Map<String, String>> getHeader() async {
    Locale lang = await AppPreferencesHelper().getSelectedLanguage();
    return {
      "Accept": "application/json",
      'Content-Type': 'application/x-www-form-urlencoded',
      "lang": lang.languageCode
    };
  }

  Webservice();

  Future<ErrorType> checkErrorType(DefaultResponse defaultResponse) async {
    print(dialog);
    if (dialog == null) {
      // var defaultResponse = DefaultResponse.fromJson(body);
      if (defaultResponse.error?.code == 8) {
        //session time out
        dialog = Navigator.of(_buildContext, rootNavigator: true).pushNamed(
          "/login",
          arguments: true,
        );
        var result = await dialog;
        dialog = null;
        if (result is ActivityResult) {
          if (result.code == ActivityResultCode.ACTIVITY_OK) {
            updatedToken = result.result;
            print("token " + updatedToken!);
            return ErrorType.RETRY;
          } else {
            return ErrorType.SESSION_TIMEOUT;
          }
        } else {
          return ErrorType.SESSION_TIMEOUT;
        }
      } else if (defaultResponse.error?.code! == 33) {
        dialog = updateDialog(_buildContext, forceUpdate: true);
        await dialog;
        dialog = null;
        return ErrorType.APP_OUTDATED;
      } else {
        return ErrorType.OK;
      }
    }
    return ErrorType.NONE;
  }

  Future<bool> isInternet() async {
    if (BASE_HOST_URL.contains("192.168")) {
      return true;
    }
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  Future<String> postRequest<R>(String endPoint, Map data) async {
    if (!await isInternet()) {
      throw Exception("Check your Internet connection");
    }
    final response = await http.post(Uri.parse(Webservice.BASE_URL + endPoint),
        headers: await getHeader(), body: data);

    if (response.statusCode == 200) {
      // final body = jsonDecode(response.body);
      return response.body;
    } else {
      var defaultResponse = DefaultResponse.fromJson(jsonDecode(response.body));
      ErrorType errorType = await checkErrorType(defaultResponse);
      if (errorType == ErrorType.RETRY) {
        return postRequest(endPoint, data);
      } else {
        throw Exception(defaultResponse.error!.errorMessage);
      }
    }
  }
}
