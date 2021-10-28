import 'package:UEnicsERP/ui/base/BaseViewModel.dart';
import 'package:UEnicsERP/ui/splashScreen/splash_view.dart';

class SplashVM extends BaseViewModel<SplashView, Object> {
  void checkIfAlreadyLoggedIn() {
    dataManager.isRememberCredentials().then((value) {
      if (value != null && value) {
        Future.delayed(const Duration(seconds: 2), () {
          navigator?.openDashboardActivity();
        });
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          navigator?.openLoginActivity();
        });
      }
    });
  }
}
