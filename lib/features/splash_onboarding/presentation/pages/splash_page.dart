import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taskor/core/config/router/routers_name.dart';
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
          context.go(RoutesName.main);
        }
      },
      child: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
