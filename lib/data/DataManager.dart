import 'local/prefs/PreferencesHelper.dart';

abstract class DataManager implements PreferencesHelper {}

enum LoggedInMode {
  LOGGED_IN_MODE_LOGGED_OUT,
  LOGGED_IN_MODE_GUEST,
  LOGGED_IN_MODE_GOOGLE,
  LOGGED_IN_MODE_FB,
  LOGGED_IN_MODE_SERVER,
}

enum LoggedInPlatform {
  LOGGED_IN_PLATFORM_TRADER,
  LOGGED_IN_PLATFORM_AUCTIONER,
}
