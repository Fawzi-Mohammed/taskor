import 'package:taskor/core/config/constants/request_constants.dart';
import 'package:taskor/core/services/local/shared_pref_service.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  String? getToken();
  Future<void> clearToken();
  Future<void> cacheRememberMe(bool rememberMe);
  bool getRememberMe();
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
  Future<void> cacheRememberMe(bool rememberMe) {
    return _sharedPrefService.setBool(RequestConstants.rememberMe, rememberMe);
  }

  @override
  bool getRememberMe() {
    return _sharedPrefService.getBool(RequestConstants.rememberMe);
  }
}
