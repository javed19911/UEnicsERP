import 'dart:async';

import 'package:UEnicsERP/data/repository/auth/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/DataManager.dart';
import '../../ui/base/BaseViewModel.dart';

import 'login_view.dart';

class LoginVM extends BaseViewModel<LoginView, AuthRepository> {
  late String phoneNumber;

  void checkIfAlreadyLoggedIn() {
    dataManager.isRememberCredentials().then((value) {
      if (value != null && value) {
        Future.delayed(const Duration(milliseconds: 40), () {
          navigator?.openDashboardActivity();
        });
      }
    });
  }

  void validateUser(BuildContext context, String email, String password) {
    mIsLoading = true;

    notifyListeners();
    getRepository()?.login(email, password).then((response) {
      dataManager.setRememberCredentials(true);
      dataManager.setCurrentUserId(response.user!.id);
      dataManager.setCurrentUserName(
          "${response.user!.firstName} ${response.user!.lastName}");
      dataManager.setAccessToken(response.user!.code);
      dataManager
          .setCurrentUserLoggedInMode(LoggedInMode.LOGGED_IN_MODE_SERVER);
      dataManager.setCurrentUserEmail(response.user!.userDetails!.email);
      dataManager
          .setCurrentUserMobileNo(response.user?.userDetails!.mobileNumber);
      // dataManager.setCurrentUserRole(response.user?.userType);

      navigator?.openDashboardActivity();
    }).catchError((e) {
      print("Got error: ${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.toString().replaceAll("Exception: ", ""),
        ),
        duration: Duration(seconds: 3),
      ));
    }).whenComplete(() {
      mIsLoading = false;
      notifyListeners();
    });
  }
}
