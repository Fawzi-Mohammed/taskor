import 'package:taskor/core/config/constants/request_constants.dart';
import 'package:taskor/core/services/local/shared_pref_service.dart';

abstract class OnboardingLocalDataSource {
  Future<bool> getOnboardingCompleted();
  Future<void> setOnboardingCompleted();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  const OnboardingLocalDataSourceImpl(this._prefsService);

  final SharedPrefService _prefsService;

  @override
  Future<bool> getOnboardingCompleted() async {
    return _prefsService.getBool(RequestConstants.onboardingCompleted);
  }

  @override
  Future<void> setOnboardingCompleted() async {
    await _prefsService.setBool(RequestConstants.onboardingCompleted, true);
  }
}
