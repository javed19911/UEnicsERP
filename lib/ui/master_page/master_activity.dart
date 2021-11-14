import 'package:UEnicsERP/ui/base/BaseActivity.dart';
import 'package:UEnicsERP/utils/customWidget/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'components/MasterMobileActivity.dart';
import 'components/MasterWebActivity.dart';
import 'master_vm.dart';

class MasterActivity extends StatefulWidget {
  const MasterActivity({Key? key}) : super(key: key);

  @override
  _MasterActivityState createState() => _MasterActivityState();
}

class _MasterActivityState extends BaseActivity<MasterActivity, MasterVM> {
  FocusNode _focusNode = FocusNode();

  @override
  void onCreate() {
    // TODO: implement onCreate
    var vm = getViewModel();
    if (vm != null) {
      Future.delayed(const Duration(milliseconds: 100), () {
        vm.getMenus(context);
      });
    }

    super.onCreate();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /*_focusNode.onKey = (FocusNode node, RawKeyEvent event) {
      //if (event is RawKeyDownEvent) {
      if (event.isKeyPressed(LogicalKeyboardKey.space)) {
        print("space bar pressed");
        return KeyEventResult.handled;
      }
      //}
      return KeyEventResult.ignored;
    };*/
  }

  @override
  Widget getWidget(BuildContext context, MasterVM? viewModel) {
    return
        // RawKeyboardListener(
        // autofocus: true,
        // focusNode: _focusNode,
        // onKey: (event) {
        //   // print(event.physicalKey);
        // },
        // child:
        ScreenTypeLayout(
      mobile: MasterMobileActivity(),
      tablet: MasterMobileActivity(),
      desktop: MasterWebActivity(),
      // ),
    );
  }
}

class MasterSetupActivity extends StatefulWidget {
  const MasterSetupActivity({Key? key}) : super(key: key);

  @override
  _MasterSetupActivityState createState() => _MasterSetupActivityState();
}

class _MasterSetupActivityState extends State<MasterSetupActivity> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _isExitDesired,
        child: Navigator(
            key: _navigatorKey,
            initialRoute: '/',
            onGenerateRoute: (RouteSettings settings) {
              // final args = settings.arguments;

              switch (settings.name) {
                case '/':
                  return MaterialPageRoute(
                      builder: (_) => ChangeNotifierProvider(
                            create: (context) => MasterVM(),
                            child: MasterActivity(),
                          ));

                default:
                  // If there is no such named route in the switch statement, e.g. /third
                  return MaterialPageRoute(
                      builder: (_) => Container(
                            alignment: Alignment.center,
                            child: SimpleText(
                                "404 Page not found for route ${settings.name}"),
                          ));
              }
            }));
  }

  Future<void> _onExitPressed() async {
    final isConfirmed = await _isExitDesired();

    if (isConfirmed) {
      _exitSetup();
    }
  }

  Future<bool> _isExitDesired() async {
    if (_navigatorKey.currentState!.canPop()) {
      _navigatorKey.currentState!.pop(false);
      return false;
    }
    return await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Are you sure?'),
                content: Text(
                    'If you exit device setup, your progress will be lost.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text('Leave'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text('Stay'),
                  ),
                ],
              );
            }) ??
        false;
  }

  void _exitSetup() {
    Navigator.of(context).pop();
  }
}
