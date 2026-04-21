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
import 'package:taskor/core/config/widgets/app_header.dart';
import 'package:taskor/core/config/widgets/app_rich_text.dart';
import 'package:taskor/core/config/widgets/app_snack_bar.dart';
import 'package:taskor/core/config/widgets/app_text_field.dart';
import 'package:taskor/features/auth/domain/value_objects/signup_data.dart';
import 'package:taskor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskor/features/auth/presentation/bloc/auth_event.dart';
import 'package:taskor/features/auth/presentation/bloc/auth_state.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _hourlyRateController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _hourlyRateController.dispose();
    super.dispose();
  }

  void _submitSignUp() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    FocusScope.of(context).unfocus();
    final normalizedRate = _hourlyRateController.text
        .trim()
        .replaceAll(',', '')
        .replaceAll(r'$', '');
    final hourlyRate = double.tryParse(normalizedRate) ?? 0;

    context.read<AuthBloc>().add(
      SignUpEvent(
        SignupData(
          name: _nameController.text.trim(),
          username: _usernameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          hourlyRate: hourlyRate,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSignUpSuccess) {
          context.go(RoutesName.login);
          return;
        }

        if (state is AuthError && state.action == AuthAction.signUp) {
          AppSnackBar.showError(context, message: state.message);
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
                const AppHeader(title: AppStrings.createAccount),
                const SizedBox(height: AppSizes.s16),
                Text(
                  AppStrings.createAccountSubtitle,
                  style: AppTextStyles.regular11,
                ),
                const SizedBox(height: AppSizes.s24),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.nameString,
                        style: AppTextStyles.semiBold14,
                      ),
                      const SizedBox(height: AppSizes.s12),
                      AppTextField(
                        controller: _nameController,
                        hintText: Text(
                          AppStrings.nameHintString,
                          style: AppTextStyles.regular11,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.s6,
                          ),
                          child: SvgPicture.asset(
                            IconPath.profile,
                            width: AppSizes.icon16,
                            height: AppSizes.icon16,
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(
                              ColorManager.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),
                        validator: (value) => value.validateName(
                          fieldName: AppStrings.nameString,
                        ),
                      ),
                      const SizedBox(height: AppSizes.s16),
                      Text('Username', style: AppTextStyles.semiBold14),
                      const SizedBox(height: AppSizes.s12),
                      AppTextField(
                        controller: _usernameController,
                        hintText: Text(
                          'Enter Username',
                          style: AppTextStyles.regular11,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.s6,
                          ),
                          child: SvgPicture.asset(
                            IconPath.profile,
                            width: AppSizes.icon16,
                            height: AppSizes.icon16,
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(
                              ColorManager.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),
                        validator: (value) =>
                            value.validateName(fieldName: 'Username'),
                      ),
                      const SizedBox(height: AppSizes.s16),
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
                      const SizedBox(height: AppSizes.s16),
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
                      const SizedBox(height: AppSizes.s16),
                      Text(
                        AppStrings.hourlyRateString,
                        style: AppTextStyles.semiBold14,
                      ),
                      const SizedBox(height: AppSizes.s12),
                      AppTextField(
                        controller: _hourlyRateController,
                        keyboardType: TextInputType.number,
                        hintText: Text(
                          AppStrings.hourlyRateHintString,
                          style: AppTextStyles.regular11,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.s16,
                          ),
                          child: SvgPicture.asset(
                            IconPath.hourlyRate,
                            width: AppSizes.icon24,
                            height: AppSizes.icon24,
                            fit: BoxFit.contain,
                          ),
                        ),
                        suffixIconConstraints: const BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),
                        validator: (value) => value.validateHourlyRate(
                          fieldName: AppStrings.hourlyRateString,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.s40),
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) {
                    final wasSignUpLoading =
                        previous is AuthLoading &&
                        previous.action == AuthAction.signUp;
                    final isSignUpLoading =
                        current is AuthLoading &&
                        current.action == AuthAction.signUp;
                    return wasSignUpLoading != isSignUpLoading;
                  },
                  builder: (context, state) {
                    final isLoading =
                        state is AuthLoading &&
                        state.action == AuthAction.signUp;
                    return AppElevatedButton(
                      label: AppStrings.signUpString,
                      onPressed: isLoading ? null : _submitSignUp,
                      isLoading: isLoading,
                      backGroundColor: ColorManager.primary,
                      borderRadius: AppSizes.s4,
                      textStyle: AppTextStyles.bold15.withColor(Colors.white),
                    );
                  },
                ),
                const SizedBox(height: AppSizes.s10),
                Center(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      AppRichText(
                        firstText: AppStrings.alreadyHaveAccountString,
                        actionText: AppStrings.loginString,
                        onTap: () => context.go(RoutesName.login),
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
