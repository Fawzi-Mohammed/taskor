import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskor/core/config/router/routers_name.dart';
import 'package:taskor/features/auth/presentation/pages/enter_email_address_page.dart';
import 'package:taskor/features/auth/presentation/pages/enter_code_page.dart';
import 'package:taskor/features/auth/presentation/pages/create_new_password_page.dart';
import 'package:taskor/features/auth/presentation/pages/login_failed_page.dart';
import 'package:taskor/features/auth/presentation/pages/login_page.dart';
import 'package:taskor/features/auth/presentation/pages/signup_page.dart';
import 'package:taskor/features/splash_onboarding/presentation/pages/onboarding_page.dart';
import 'package:taskor/features/splash_onboarding/presentation/pages/splash_page.dart';
import 'package:taskor/main.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: RoutesName.splash,
    routes: [
      // Splash / Onboarding
      GoRoute(
        path: RoutesName.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: RoutesName.splash,
        builder: (context, state) => const SplashPage(),
      ),

      // Auth
      GoRoute(
        path: RoutesName.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RoutesName.signUp,
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: RoutesName.loginFailed,
        builder: (context, state) {
          return LoginFailedPage();
        },
      ),

      // Forgot Password flow
      GoRoute(
        path: RoutesName.forgotEmail,
        builder: (context, state) => const EnterEmailAddressPage(),
      ),
      GoRoute(
        path: RoutesName.verifyCode,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is! Map) {
            return const EnterEmailAddressPage();
          }

          final email = (extra['email'] as String?)?.trim() ?? '';
          final verificationCode =
              (extra['verificationCode'] as String?)?.trim() ?? '1234';

          if (email.isEmpty) {
            return const EnterEmailAddressPage();
          }

          return EnterCodePage(
            email: email,
            verificationCode: verificationCode,
          );
        },
      ),
      GoRoute(
        path: RoutesName.resetPassword,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is! Map) {
            return const LoginPage();
          }

          final email = (extra['email'] as String?)?.trim() ?? '';
          final code = (extra['code'] as String?)?.trim() ?? '';

          if (email.isEmpty || code.isEmpty) {
            return const LoginPage();
          }

          return CreateNewPasswordPage(email: email, code: code);
        },
      ),

      // Main (Bottom Nav Shell)
      GoRoute(
        path: RoutesName.main,
        builder: (context, state) => const MainScaffold(),
        routes: [
          GoRoute(
            path: RoutesName.home,
            builder: (context, state) => const _PlaceholderPage(title: 'Home'),
          ),
          GoRoute(
            path: RoutesName.projects,
            builder: (context, state) =>
                const _PlaceholderPage(title: 'Projects List'),
            routes: [
              GoRoute(
                path: RoutesName.createProject,
                builder: (context, state) =>
                    const _PlaceholderPage(title: 'Create Project'),
              ),
              GoRoute(
                path: RoutesName.projectDetails,
                builder: (context, state) =>
                    const _PlaceholderPage(title: 'Project Details'),
              ),
            ],
          ),
          GoRoute(
            path: RoutesName.profile,
            builder: (context, state) =>
                const _PlaceholderPage(title: 'Profile'),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => _PlaceholderPage(
      title: 'Route Error',
      subtitle: state.error.toString(),
    ),
  );
}

/// ✅ Placeholder page (no UI implementation, just to compile and test navigation)
class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          subtitle ?? 'TODO: Build $title UI',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
