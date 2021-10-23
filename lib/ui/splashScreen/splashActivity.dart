import 'package:UEnicsERP/ui/base/BaseActivity.dart';
import 'package:UEnicsERP/ui/splashScreen/vmSplash.dart';
import 'package:UEnicsERP/utils/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progress_indicators/progress_indicators.dart';

class SplashActivity extends StatefulWidget {
  const SplashActivity({Key? key}) : super(key: key);

  @override
  _SplashActivityState createState() => _SplashActivityState();
}

class _SplashActivityState extends BaseActivity<SplashActivity, vmSplash> {
  @override
  Widget getWidget(BuildContext context, vmSplash? view_model) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Logo(),
          // JumpingDotsProgressIndicator(
          //   fontSize: 80.0,
          // ),
        ],
      ),
    );
  }
}
