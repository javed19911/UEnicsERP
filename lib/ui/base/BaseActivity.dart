import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'ActivityResult.dart';
import 'BaseViewModel.dart';

abstract class BaseActivity<S extends StatefulWidget, VM extends BaseViewModel>
    extends State<S> with WidgetsBindingObserver {
  VM? _view_model;

  int _create_count = 0;
  bool isCreated = false;

  Widget getWidget(BuildContext context, VM? viewModel);

  VM? getViewModel() {
    try {
      _view_model = Provider.of<VM>(context);
      _view_model?.buildContext = context;
    } catch (e) {
      _view_model = null;
      // print(e.toString());
    }
    return _view_model;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  /* @override
  void didUpdateWidget(S oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("on didUpdateWidget " + (_create_count.toString()));
    if(oldWidget == null){
      onCreate();
    }
  }
*/

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //print("on didChangeDependencies " + (_create_count.toString()));

    _create_count++;
    if (_create_count == 1) {
      // _create_count++;
      //print("on create inside2- " +  (_create_count.toString()));
      onCreate();
      isCreated = true;
    }
    /* if (_create_count == 0) {
      print("on didChangeDependencies inside " + (_create_count.toString()));
      onCreate();
      */ /*Future.delayed(const Duration(milliseconds: 500), () {

        setState(() {
          // Here you can write your code for open new view
        });

      });*/ /*
    }*/
  }

  @mustCallSuper
  void onCreate() {
    //print("on super create inside- " + (_create_count.toString()));
    //_create_count++;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: isCreated
            ? Container(
                color: Theme.of(context).colorScheme.primaryVariant,
                child: SafeArea(
                  child: Container(
                    color: Colors.white,
                    child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        // child: FocusTraversalGroup(
                        //     policy: OrderedTraversalPolicy(),
                        child: getWidget(context, getViewModel())
                        // )
                        ),
                  ),
                ),
              )
            : Container(),
        onWillPop: onBackPressed);
  }

  void clearAllActivities() {
    Navigator.of(context).pushNamedAndRemoveUntil("/", (r) => false);
  }

  void onActivityResult(int result_code, ActivityResult result) {}

  void finish() {
    Navigator.of(context).pop(ActivityResult());
  }

  void startActivity(Widget activity,
      {bool rootNavigator = false, NavigatorState? navigatorKey}) {
    if (navigatorKey != null) {
      navigatorKey.pushReplacement(
        MaterialPageRoute(builder: (context) => activity),
      );
    } else {
      Navigator.of(context, rootNavigator: rootNavigator).push(
        MaterialPageRoute(builder: (context) => activity),
      );
    }
  }

  void replaceActivity(Widget activity,
      {bool rootNavigator = false, NavigatorState? navigatorKey}) {
    if (navigatorKey != null) {
      navigatorKey.pushReplacement(
        MaterialPageRoute(builder: (context) => activity),
      );
    } else {
      Navigator.of(context, rootNavigator: rootNavigator).pushReplacement(
        MaterialPageRoute(builder: (context) => activity),
      );
    }
  }

  void startNamedActivity(String page,
      {Object? args,
      bool rootNavigator = false,
      NavigatorState? navigatorKey}) {
    if (navigatorKey != null) {
      navigatorKey.pushNamed(page, arguments: args);
    } else {
      Navigator.of(context, rootNavigator: rootNavigator)
          .pushNamed(page, arguments: args);
    }
  }

  void replaceNamedActivity(String page,
      {Object? args,
      bool rootNavigator = false,
      NavigatorState? navigatorKey}) {
    if (navigatorKey != null) {
      navigatorKey.pushNamed(page, arguments: args);
    } else {
      Navigator.of(context, rootNavigator: rootNavigator)
          .pushReplacementNamed(page, arguments: args);
    }
  }

  void setActivityResult(ActivityResultCode code, dynamic result) {
    Navigator.pop(context, ActivityResult.codeResult(code, result));
  }

  void startActivityforResult(Widget activity, int result_code) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => activity),
    ).then((result) => (result is ActivityResult)
        ? onActivityResult(result_code, result)
        : onActivityResult(
            result_code,
            ActivityResult.codeResult(
                ActivityResultCode.ACTIVITY_CANCEL, result)));
  }

  void startNamedActivityforResult(String page, int result_code,
      {Object? args}) {
    Navigator.pushNamed(context, page, arguments: args).then((result) =>
        (result is ActivityResult)
            ? onActivityResult(result_code, result)
            : onActivityResult(
                result_code,
                ActivityResult.codeResult(
                    ActivityResultCode.ACTIVITY_CANCEL, result)));
  }

  void showAsDialogForResult(Widget activity, int result_code) {
    showDialog(
            context: context,
            builder: (BuildContext context) {
              return activity;
            })
        .then((result) => (result is ActivityResult)
            ? onActivityResult(result_code, result)
            : onActivityResult(
                result_code,
                ActivityResult.codeResult(
                    ActivityResultCode.ACTIVITY_CANCEL, result)));
  }

  Future<bool> onBackPressed() async {
    //finish();
    return true;
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 14.0);
  }
}
