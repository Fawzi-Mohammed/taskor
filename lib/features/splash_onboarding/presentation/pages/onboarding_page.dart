import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taskor/core/config/constants/app_sizes.dart';
import 'package:taskor/core/config/constants/app_strings.dart';
import 'package:taskor/core/config/constants/color_manager.dart';
import 'package:taskor/core/config/constants/app_text_styles.dart';
import 'package:taskor/core/config/constants/image_path.dart';
import 'package:taskor/core/config/extensions/padding_extension.dart';
import 'package:taskor/core/config/extensions/text_style_extension.dart';
import 'package:taskor/core/config/router/routers_name.dart';
import 'package:taskor/core/config/widgets/app_elevated_button.dart';
import 'package:taskor/core/config/widgets/custom_text_button.dart';
import 'package:taskor/core/config/widgets/dots_indicator.dart';
import 'package:taskor/core/config/widgets/onboarding_content.dart';
import 'package:taskor/features/splash_onboarding/presentation/bloc/splash_onboarding_bloc.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<_OnboardingItem> _items = [
    _OnboardingItem(
      imagePath: ImagePath.onboarding1,
      title: AppStrings.onBoardingTitleOneString,
      subTitle: AppStrings.onBoardingSubTitleOneString,
      titleTextStyle: AppTextStyles.bold18,
      subTitleTextStyle: AppTextStyles.regular13,
    ),
    _OnboardingItem(
      imagePath: ImagePath.onboarding2,
      title: AppStrings.onBoardingTitleTwoString,
      subTitle: AppStrings.onBoardingSubTitleTwoString,
      titleTextStyle: AppTextStyles.bold18,
      subTitleTextStyle: AppTextStyles.regular13,
    ),
    _OnboardingItem(
      imagePath: ImagePath.onboarding3,
      title: AppStrings.onBoardingTitleThreeString,
      subTitle: AppStrings.onBoardingSubTitleThreeString,
      titleTextStyle: AppTextStyles.bold18,
      subTitleTextStyle: AppTextStyles.regular13.withColor(Colors.white),
    ),
  ];
  final _color = const [
    Colors.white,
    ColorManager.inActiveDOtesColor,
    ColorManager.primary,
  ];
  bool get _isLastPage => _currentIndex == _items.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  void _onSkipPressed() {
    context.read<SplashOnboardingBloc>().add(const OnboardingCompletedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashOnboardingBloc, SplashOnboardingState>(
      listener: (context, state) {
        if (state is NavigateToHome) {
          context.go(RoutesName.main);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          color: _color[_currentIndex],
          child: SafeArea(
            bottom: true,
            child: Column(
              children: [
                // Skip
                !_isLastPage
                    ? Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: CustomTextButton(
                          textStyle: AppTextStyles.semiBold15,
                          label: AppStrings.skipString,
                          onPressed: _onSkipPressed,
                        ),
                      )
                    : SizedBox(),

                // PageView
                Expanded(
                  flex: 1,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _items.length,
                    onPageChanged: (index) =>
                        setState(() => _currentIndex = index),
                    itemBuilder: (_, index) {
                      final item = _items[index];
                      return OnboardingContent(
                        imagePath: item.imagePath,
                        title: item.title,
                        subTitle: item.subTitle,
                        titleTextStyle: item.titleTextStyle,
                        subTitleTextStyle: item.subTitleTextStyle,
                      );
                    },
                  ),
                ),

                const SizedBox(height: AppSizes.s34),

                // Dots Indicator
                DotsIndicator(
                  currentIndex: _currentIndex,
                  totalDots: _items.length,
                  activeColor: _isLastPage
                      ? Colors.white
                      : ColorManager.primary,
                  inActiveColor: ColorManager.inActiveDOtesColor,
                ),

                const SizedBox(height: AppSizes.s8),

                // Button
                AppElevatedButton(
                  label: _isLastPage
                      ? AppStrings.getStartedString
                      : AppStrings.nextString,
                  onPressed: _isLastPage ? _onSkipPressed : _onNextPressed,
                  backGroundColor: _isLastPage
                      ? Colors.white
                      : ColorManager.primary,
                  borderRadius: AppSizes.r6,
                  textStyle: _isLastPage
                      ? AppTextStyles.bold15
                      : AppTextStyles.bold15.withColor(Colors.white),
                ),

                const SizedBox(height: AppSizes.r100),
              ],
            ).padSym(horizontal: AppSizes.s20, vertical: AppSizes.s32),
          ),
        ),
      ),
    );
  }
}

class _OnboardingItem {
  final String imagePath;
  final String title;
  final String subTitle;
  final TextStyle titleTextStyle;
  final TextStyle subTitleTextStyle;
  const _OnboardingItem({
    required this.imagePath,
    required this.title,
    required this.subTitle,
    required this.titleTextStyle,
    required this.subTitleTextStyle,
  });
}
