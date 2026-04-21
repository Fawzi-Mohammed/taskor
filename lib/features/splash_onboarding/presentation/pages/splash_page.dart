import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taskor/core/config/router/routers_name.dart';
import 'package:taskor/core/di/service_locator.dart';
import 'package:taskor/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:taskor/features/splash_onboarding/presentation/bloc/splash_onboarding_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<SplashOnboardingBloc>().add(AppStartedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashOnboardingBloc, SplashOnboardingState>(
      listenWhen: (previous, current) =>
          current is ShowOnboarding || current is NavigateToHome,
      listener: (context, state) {
        if (state is ShowOnboarding) {
          context.go(RoutesName.onboarding);
        } else if (state is NavigateToHome) {
          final localDataSource = sl<AuthLocalDataSource>();
          final token = localDataSource.getToken();
          final rememberMe = localDataSource.getRememberMe();
          final hasSignedUp = localDataSource.getHasSignedUp();

          final shouldGoHome = rememberMe && (token?.isNotEmpty ?? false);
          if (shouldGoHome) {
            context.go(RoutesName.main);
            return;
          }

          context.go(hasSignedUp ? RoutesName.login : RoutesName.signUp);
        }
      },
      child: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
