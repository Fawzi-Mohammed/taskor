import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:taskor/core/config/constants/app_sizes.dart';
import 'package:taskor/core/config/constants/app_strings.dart';
import 'package:taskor/core/config/constants/app_text_styles.dart';
import 'package:taskor/core/config/constants/color_manager.dart';
import 'package:taskor/core/config/constants/icon_path.dart';
import 'package:taskor/core/config/extensions/text_style_extension.dart';
import 'package:taskor/core/config/extensions/validation_extension.dart';
import 'package:taskor/core/config/router/routers_name.dart';
import 'package:taskor/core/config/widgets/app_elevated_button.dart';
import 'package:taskor/core/config/widgets/app_rich_text.dart';
import 'package:taskor/core/config/widgets/app_text_field.dart';
import 'package:taskor/features/auth/domain/value_objects/login_credentials.dart';
import 'package:taskor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskor/features/auth/presentation/bloc/auth_event.dart';
import 'package:taskor/features/auth/presentation/bloc/auth_state.dart';
import 'package:taskor/core/config/widgets/app_header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.go(RoutesName.main);
        } else if (state is AuthFailureState) {
          context.go(RoutesName.loginFailed);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.s20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSizes.s12),
                const AppHeader(title: AppStrings.loginString),
                const SizedBox(height: AppSizes.s20),
                Text(AppStrings.welcomeBackString, style: AppTextStyles.bold15),
                const SizedBox(height: AppSizes.s4),
                Text(
                  AppStrings.welcomeBackSubtitleString,
                  style: AppTextStyles.regular13,
                ),
                const SizedBox(height: AppSizes.s24),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.emailString,
                        style: AppTextStyles.semiBold14,
                      ),
                      const SizedBox(height: AppSizes.s12),
                      AppTextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: Text(
                          AppStrings.emailStringHint,
                          style: AppTextStyles.regular11,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.s6,
                          ),
                          child: SvgPicture.asset(
                            IconPath.emailIcon,
                            width: AppSizes.icon16,
                            height: AppSizes.icon16,
                            fit: BoxFit.cover,
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),
                        validator: (value) => value.validateEmail(),
                      ),
                      const SizedBox(height: AppSizes.s14),
                      Text(
                        AppStrings.passwordString,
                        style: AppTextStyles.semiBold14,
                      ),
                      const SizedBox(height: AppSizes.s12),
                      AppTextField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: Text(
                          AppStrings.passwordStringHint,
                          style: AppTextStyles.regular11,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.s6,
                          ),
                          child: SvgPicture.asset(
                            IconPath.passwordIcon,
                            width: AppSizes.icon16,
                            height: AppSizes.icon16,
                            fit: BoxFit.contain,
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),
                        isPassword: true,
                        validator: (value) => value.validatePassword(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.s16),
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      activeColor: ColorManager.primary,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: const VisualDensity(
                        horizontal: -4,
                        vertical: -4,
                      ),
                      onChanged: (value) =>
                          setState(() => _rememberMe = value ?? false),
                    ),
                    const SizedBox(width: AppSizes.s6),
                    Text(
                      AppStrings.rememberMeString,
                      style: AppTextStyles.medium11,
                    ),
                  ],
                ),

                const SizedBox(height: AppSizes.s40),
                AppElevatedButton(
                  label: AppStrings.loginString,
                  onPressed: () {
                    final isValid = _formKey.currentState?.validate() ?? false;
                    if (!isValid) {
                      return;
                    }
                    FocusScope.of(context).unfocus();
                    context.read<AuthBloc>().add(
                      LoginSubmitted(
                        LoginCredentials(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        ),
                      ),
                    );
                  },
                  backGroundColor: ColorManager.primary,
                  borderRadius: AppSizes.s4,
                  textStyle: AppTextStyles.bold15.withColor(Colors.white),
                ),
                const SizedBox(height: AppSizes.s10),
                Center(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      AppRichText(
                        firstText: AppStrings.dontHaveAccountString,
                        actionText: AppStrings.createAccount,
                        onTap: () => context.go(RoutesName.signUp),
                        textAlign: TextAlign.center,
                        firstTextStyle: AppTextStyles.regular10,
                        actionTextStyle: AppTextStyles.regular10.withColor(
                          ColorManager.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.s24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
