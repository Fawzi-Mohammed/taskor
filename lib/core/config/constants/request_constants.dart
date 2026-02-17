class RequestConstants {
  RequestConstants._();

  static const String baseUrl = 'https://api.mohammedzomlot.dev';

  static const String loginPath = '/auth/login';
  static const String signupPath = '/auth/signup';
  static const String forgotPasswordPath = '/auth/forgotPassword';
  static const String verifyResetCodePath = '/auth/checkCode';
  static const String resetPasswordPath = '/auth/resetPassword';

  static const String authToken = 'auth_token';
  static const String rememberMe = 'remember_me';
  static const String onboardingCompleted = 'onboarding_completed';
}
