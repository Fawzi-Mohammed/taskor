class RequestConstants {
  RequestConstants._();

  static const String baseUrl = 'https://api.mohammedzomlot.dev';

  static final String loginPath = '/User/login';
  static final String signupPath = '/user/signup';
  static final String forgotPasswordPath = '/user/forgotPassword';
  static final String verifyResetCodePath = '/user/checkCodeController';
  static final String resetPasswordPath = '/user/resetPassword';

  static const String authToken = 'auth_token';
  static const String watchCost = 'watch_cost';
  static const String rememberMe = 'remember_me';
  static const String hasSignedUp = 'has_signed_up';
  static const String onboardingCompleted = 'onboarding_completed';
}
