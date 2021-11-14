import 'package:UEnicsERP/data/repository/service_locator.dart';
import 'package:flutter/cupertino.dart';
import '../../data/AppDataManager.dart';
import '../../data/DataManager.dart';
/*import 'package:praman_flutter/data/AppDataManager.dart';
import 'package:praman_flutter/data/DataManager.dart';*/

abstract class BaseViewModel<N, R extends Object> extends ChangeNotifier {
  bool _mIsLoading = false;
  late AppDataManager _dataManager;
  late BuildContext _buildContext;

  set buildContext(BuildContext value) {
    _buildContext = value;
    _dataManager.buildContext = value;
  }

  BuildContext get buildContext {
    return _buildContext;
  }

  R? _repository;

  R? getRepository() {
    if (_repository == null) {
      try {
        _repository = locator.get<R>();
      } catch (e) {
        _repository = null;
      }
    }
    return _repository;
  }

  N? _navigator;

  N? get navigator => _navigator;

  set navigator(N? value) {
    _navigator = value;
  }

  BaseViewModel() {
    _dataManager = AppDataManager();
  }

  DataManager get dataManager => _dataManager;

  bool get mIsLoading => _mIsLoading;

  set mIsLoading(bool isLoading) {
    _mIsLoading = isLoading;
  }
}
