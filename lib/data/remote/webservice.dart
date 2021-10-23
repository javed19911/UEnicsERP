import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:UEnicsERP/multiLanguage/lanuages/language.dart';
import 'package:UEnicsERP/ui/base/ActivityResult.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';
import '../../utils/UtilFunctions.dart';
import '../local/prefs/AppPreferencesHelper.dart';
import '../models/CommodityResponse.dart';
import '../models/LotResponse.dart';
import '../models/default_response.dart';
import '../models/login_reponse.dart';

import 'ApiHelper.dart';

enum ErrorType { NONE, OK, APP_OUTDATED, SESSION_TIMEOUT, RETRY }

class Webservice implements ApiHelper {
  late BuildContext _buildContext;
  Future? dialog = null;
  String? updatedToken = null;

  set buildContext(BuildContext value) {
    _buildContext = value;
  }

  //staging
  // static String BASE_HOST_URL = "https://uenics-erp.herokuapp.com";

  //development
  static String BASE_HOST_URL = "http://127.0.0.1:5000";

  //production
  //static final String BASE_HOST_URL = "http://staging.praman.ai" ;
  static String BASE_URL = BASE_HOST_URL + "/";

  Future<Map<String, String>> getHeader() async {
    Locale lang = await AppPreferencesHelper().getSelectedLanguage();
    return {
      "Accept": "application/json",
      "Content-Type": "application/json",
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

  @override
  Future<LoginReponse> validateUser(String email, String password) async {
    if (!await isInternet()) {
      throw Exception("Check your Internet connection");
    }
    ;
    int timeZoneOffset = UtilFunctions.getLocalTimezoneOffsetInSeconds();

    Map data = {"user_id": "$email", "password": "$password"};

    //String body = json.encode(data);

    final response = await http.post(Uri.parse(BASE_URL + "auth/login"),
        headers: {
          "Accept": "application/json",
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: data);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return LoginReponse.fromJson(body);
    } else {
      var defaultResponse = DefaultResponse.fromJson(jsonDecode(response.body));
      ErrorType errorType = await checkErrorType(defaultResponse);
      if (errorType == ErrorType.RETRY) {
        return validateUser(email, password);
      } else {
        throw Exception(defaultResponse.error!.errorMessage);
      }
    }
  }

  @override
  Future<DefaultResponse> generateOTP(String phone_number) async {
    if (!await isInternet()) {
      throw Exception("Check your Internet connection");
    }

    Map data = {
      //'mobile': phone_number,
      'email': phone_number,
      'app_hashcode': "ktxrq+ZgQUQ" //release code
      //'app_hashcode': "bOT/9cpIF79" //javed's staging code
    };

    String body = json.encode(data);

    final response =
        await http.post(Uri.parse("${BASE_URL}v1/users/generate_otp"),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json",
              'Access-Control-Allow-Origin': '*',
              'Access-Control-Allow-Headers': '*'
            },
            body: body);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return DefaultResponse.fromJson(body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }

  @override
  Future<LoginReponse> validateOTP(String phone_number, String OTP) async {
    if (!await isInternet()) {
      throw Exception("Check your Internet connection");
    }
    ;

    Map data = {
      //'mobile': phone_number,
      'email': phone_number,
      'otp': OTP
    };

    String body = json.encode(data);

    final response = await http.post(
        Uri.parse(BASE_URL + "v1/users/login_with_otp"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: body);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return LoginReponse.fromJson(body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }

  @override
  Future<LotResponse> getLots(
      String token, String email, Map filterOption) async {
    if (!await isInternet()) {
      throw Exception("Check your Internet connection");
    }
    ;

    int timeZoneOffset = UtilFunctions.getLocalTimezoneOffsetInSeconds();
    //int currentTimestamp = UtilFunctions.getUnixTimeStamp(new DateTime.now());

    Map data = {
      'token': token,
      'email': email,
      'local_timezone': timeZoneOffset,
      //'date_time': currentTimestamp
      'options': filterOption
    };

    String body = json.encode(data);

    final response = await http.post(
        Uri.parse(BASE_URL + "v2/inspections/index"),
        /*final response = await http.post(
        "http://trade.praman.ai/api/v23/lots/index",*/
        headers: await getHeader(),
        body: body);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      //print("body : ${body}");
      return LotResponse.fromJson(body);
    } else {
      var defaultResponse = DefaultResponse.fromJson(jsonDecode(response.body));
      var errorType = checkErrorType(defaultResponse);
      if (errorType == ErrorType.APP_OUTDATED) {
        throw Exception(Language.of(_buildContext).appOutDated);
      } else if (errorType == ErrorType.RETRY) {
        return getLots(token, email, filterOption);
      } else {
        throw Exception(defaultResponse.error!.errorMessage);
      }
    }
  }

  @override
  Future<CommodityResponse> getCommodityList(String token, String email) async {
    if (!await isInternet()) {
      throw Exception("Check your Internet connection");
    }

    Map data = {
      'token': token,
      'email': email,
    };

    String body = json.encode(data);

    final response = await http.post(
        Uri.parse(BASE_URL + "v2/inspections/commodities"),
        /* final response = await http.post(
        "http://3.7.230.206:4000/api/pfg_test/inspections/commodities",*/
        headers: await getHeader(),
        body: body);

    if (response.statusCode == 200) {
      final body1 = jsonDecode(response.body);
      return CommodityResponse.fromJson(body1);
    } else {
      throw Exception("Unable to perform request!");
    }
  }

  @override
  Future<DefaultResponse> uploadLotImage(
      String token,
      String email,
      String temp_id,
      String location_type_name,
      String job_process_name,
      int job_process_id,
      int product_id,
      String imagePath,
      String longitude,
      String latitude,
      bool is_ai_image) async {
    if (!await isInternet()) {
      throw Exception("Check your Internet connection");
    }

    Map data = {
      "token": token,
      "email": email,
      "temp_id": temp_id,
      "location_type_name": location_type_name,
      "job_process_name": job_process_name,
      "job_process_id": job_process_id,
      "product_id": product_id,
      "image": imagePath,
      "longitude": longitude,
      "latitude": latitude,
      "is_ai_image": is_ai_image,
    };

    String body = json.encode(data);

    final response = await http
        //.post(BASE_URL + "lots/gradings/classify_vegetable", body: body);
        .post(Uri.parse("15.206.220.141:4000/api/v1/inspections/save_image"),
            body: body);

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      return DefaultResponse.fromJson(jsonBody);
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
