// core/router/routers_name.dart

class RoutesName {
  // Splash / Onboarding
  static const String splash = '/';

  // Auth
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String loginFailed = '/login-failed';

  // Forgot Password flow (from your screenshots)
  static const String forgotEmail = '/forgot-email';
  static const String verifyCode = '/verify-code';
  static const String resetPassword = '/reset-password';

  // Main Shell (bottom nav)
  static const String main = '/main';

  // Tabs
  static const String home = 'home';
  static const String projects = 'projects';
  static const String profile = 'profile';

  // Projects
  static const String projectDetails = 'project-details'; // expects extra/id
  static const String createProject = 'create-project';

  // Tasks
  static const String tasksList = 'tasks';
  static const String taskDetails = 'task-details'; // expects extra/id
  static const String createTask = 'create-task';
  static const String editTask = 'edit-task';
}
