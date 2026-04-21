import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:taskor/core/config/router/router.dart';
import 'package:taskor/core/config/router/routers_name.dart';
import 'package:taskor/core/config/widgets/app_snack_bar.dart';
import 'package:taskor/core/di/service_locator.dart';
import 'package:taskor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskor/features/auth/presentation/bloc/auth_event.dart';
import 'package:taskor/features/auth/presentation/bloc/auth_state.dart';
import 'package:taskor/features/splash_onboarding/presentation/bloc/splash_onboarding_bloc.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initServiceLocator();

  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<SplashOnboardingBloc>()),
        BlocProvider(create: (_) => sl<AuthBloc>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLogoutSuccess) {
          context.go(RoutesName.login);
          return;
        }

        if (state is AuthError && state.action == AuthAction.logout) {
          AppSnackBar.showError(context, message: state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(const LogoutEvent());
              },
              child: const Text('Logout'),
            ),
          ],
        ),
        body: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Welcome to Home Screen'));
  }
}
