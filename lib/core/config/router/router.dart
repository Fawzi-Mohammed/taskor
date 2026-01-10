import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskor/core/config/router/routers_name.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: RoutesName.splash,
    routes: [
      // Splash / Onboarding
      GoRoute(
        path: RoutesName.splash,
        builder: (context, state) => const _PlaceholderPage(title: 'Splash'),
      ),

      // Auth
      GoRoute(
        path: RoutesName.login,
        builder: (context, state) => const _PlaceholderPage(title: 'Login'),
      ),
      GoRoute(
        path: RoutesName.signUp,
        builder: (context, state) => const _PlaceholderPage(title: 'Sign Up'),
      ),
      GoRoute(
        path: RoutesName.loginFailed,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Login Failed'),
      ),

      // Forgot Password flow
      GoRoute(
        path: RoutesName.forgotEmail,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Recover by Email'),
      ),
      GoRoute(
        path: RoutesName.verifyCode,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Enter Code'),
      ),
      GoRoute(
        path: RoutesName.resetPassword,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Reset Password'),
      ),

      // Main (Bottom Nav Shell)
      GoRoute(
        path: RoutesName.main,
        builder: (context, state) => const _MainShell(),
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

/// ✅ Minimal shell just for routing structure (you will replace it later with GNav UI)
class _MainShell extends StatelessWidget {
  const _MainShell();

  @override
  Widget build(BuildContext context) {
    // Default child route: /main/home
    return const _PlaceholderPage(
      title: 'Main Shell',
      subtitle: 'Navigate to /main/home, /main/projects, /main/profile',
    );
  }
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
