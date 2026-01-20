import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:taskor/core/config/constants/app_strings.dart';
import 'package:taskor/core/config/constants/icon_path.dart';
import 'package:taskor/core/config/widgets/app_bottom_nav_bar.dart';
import 'package:taskor/core/config/constants/app_text_styles.dart';
import 'package:taskor/core/config/constants/color_manager.dart';
import 'package:taskor/core/config/extensions/text_style_extension.dart';
import 'package:taskor/core/config/router/router.dart';
import 'package:taskor/core/config/widgets/app_project_list_card.dart';
import 'package:taskor/core/config/widgets/profile_option_item.dart';
import 'package:taskor/core/di/service_locator.dart';
import 'package:taskor/features/splash_onboarding/presentation/bloc/splash_onboarding_bloc.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initServiceLocator();

  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SplashOnboardingBloc>(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _index,
        onChanged: (newIndex) => setState(() => _index = newIndex),
      ),
      body: IndexedStack(
        index: _index,
        children: const [HomePage(), ProjectsPage(), ProfilePage()],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Home Page"));
  }
}

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: AppProjectListCard(
          numberOFFinishedTasks: 2,
          numberOfTotalTasks: 5,
          numberOFFinishedHours: 10,
          numberOfTotalHours: 40,
          numberOfTasksOrProjects: 5,
          currentTaskOrProjects: 3,
          projectTitle: 'Flutter',
          clientName: 'flutter.dev',
          projectTitleTextStyle: AppTextStyles.semiBold14.withColor(
            ColorManager.primary,
          ),
          clientNameTextStyle: AppTextStyles.medium8.withColor(
            ColorManager.subtitleAndToDoColor,
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ProfileOptionItem(
          options: [
            ProfileOptionData(
              iconPath: IconPath.activeProject,
              value: '10',
              label: AppStrings.projectsString,
            ),
            ProfileOptionData(
              iconPath: IconPath.workingHours,
              value: '55',
              label: AppStrings.workingHoursString,
            ),
            ProfileOptionData(
              iconPath: IconPath.activeProject,
              value: r'$ 12,340',
              label: AppStrings.totalEarningsString,
            ),
          ],
        ),
      ),
    );
  }
}
