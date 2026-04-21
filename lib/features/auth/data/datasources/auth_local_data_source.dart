import 'package:taskor/core/config/constants/request_constants.dart';
import 'package:taskor/core/services/local/shared_pref_service.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  String? getToken();
  Future<void> clearToken();
  Future<void> cacheWatchCost(double watchCost);
  double? getWatchCost();
  Future<void> clearWatchCost();
  Future<void> cacheRememberMe(bool rememberMe);
  bool getRememberMe();
  Future<void> cacheHasSignedUp(bool hasSignedUp);
  bool getHasSignedUp();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl(this._sharedPrefService);

  final SharedPrefService _sharedPrefService;

  @override
  Future<void> cacheToken(String token) {
    return _sharedPrefService.setString(RequestConstants.authToken, token);
  }

  @override
  String? getToken() {
    return _sharedPrefService.getString(RequestConstants.authToken);
  }

  @override
  Future<void> clearToken() {
    return _sharedPrefService.remove(RequestConstants.authToken);
  }

  @override
  Future<void> cacheWatchCost(double watchCost) {
    return _sharedPrefService.setDouble(RequestConstants.watchCost, watchCost);
  }

  @override
  double? getWatchCost() {
    return _sharedPrefService.getDouble(RequestConstants.watchCost);
  }

  @override
  Future<void> clearWatchCost() {
    return _sharedPrefService.remove(RequestConstants.watchCost);
  }

  @override
  Future<void> cacheRememberMe(bool rememberMe) {
    return _sharedPrefService.setBool(RequestConstants.rememberMe, rememberMe);
  }

  @override
  bool getRememberMe() {
    return _sharedPrefService.getBool(RequestConstants.rememberMe);
  }

  @override
  Future<void> cacheHasSignedUp(bool hasSignedUp) {
    return _sharedPrefService.setBool(
      RequestConstants.hasSignedUp,
      hasSignedUp,
    );
  }

  @override
  bool getHasSignedUp() {
    return _sharedPrefService.getBool(RequestConstants.hasSignedUp);
  }
}
