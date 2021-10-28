import 'package:UEnicsERP/res/color.dart';
import 'package:UEnicsERP/ui/base/BaseActivity.dart';
import 'package:UEnicsERP/ui/splashScreen/splash_view.dart';
import 'package:UEnicsERP/ui/splashScreen/splash_vm.dart';
import 'package:UEnicsERP/utils/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progress_indicators/progress_indicators.dart';

class SplashActivity extends StatefulWidget {
  const SplashActivity({Key? key}) : super(key: key);

  @override
  _SplashActivityState createState() => _SplashActivityState();
}

class _SplashActivityState extends BaseActivity<SplashActivity, SplashVM>
    implements SplashView {
  @override
  void onCreate() {
    var vm = getViewModel();
    vm?.navigator = this;
    vm?.checkIfAlreadyLoggedIn();
    super.onCreate();
  }

  @override
  Widget getWidget(BuildContext context, SplashVM? viewModel) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: CustomColors.grayLightest(),
        alignment: Alignment.center,
        child: Stack(
          children: [
            Logo(
              color: Colors.white,
            ),
            Positioned.fill(
              child: JumpingDotsProgressIndicator(
                fontSize: 80.0,
                numberOfDots: 5,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void openDashboardActivity() {
    replaceNamedActivity("/master_setup");
  }

  @override
  void openLoginActivity() {
    replaceNamedActivity("/login");
  }
}
