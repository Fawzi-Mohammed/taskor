import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:taskor/core/config/widgets/app_snack_bar.dart';
import 'package:taskor/core/config/widgets/app_text_field.dart';
import 'package:taskor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskor/features/auth/presentation/bloc/auth_event.dart';
import 'package:taskor/features/auth/presentation/bloc/auth_state.dart';

class CreateNewPasswordPage extends StatefulWidget {
  const CreateNewPasswordPage({
    super.key,
    required this.email,
    required this.code,
  });

  final String email;
  final String code;

  @override
  State<CreateNewPasswordPage> createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleChangePassword() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    FocusScope.of(context).unfocus();

    context.read<AuthBloc>().add(
      ResetPasswordEvent(
        email: widget.email,
        code: widget.code,
        newPassword: _passwordController.text.trim(),
        confirmPassword: _confirmPasswordController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthResetPasswordSuccess) {
          context.go(RoutesName.login);
          return;
        }

        if (state is AuthError && state.action == AuthAction.resetPassword) {
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
                const AppHeader(title: AppStrings.createNewPasswordString),
                const SizedBox(height: AppSizes.s16),
                Text(
                  AppStrings.createNewPasswordSubtitleString,
                  style: AppTextStyles.regular13,
                ),
                const SizedBox(height: AppSizes.s24),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppStrings.passwordString}.',
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
                        AppStrings.confirmPasswordString.trim(),
                        style: AppTextStyles.semiBold14,
                      ),
                      const SizedBox(height: AppSizes.s12),
                      AppTextField(
                        controller: _confirmPasswordController,
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
                        validator: (value) => value.validateConfirmPassword(
                          _passwordController.text,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.s32),
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) {
                    final wasLoading =
                        previous is AuthLoading &&
                        previous.action == AuthAction.resetPassword;
                    final isLoading =
                        current is AuthLoading &&
                        current.action == AuthAction.resetPassword;
                    return wasLoading != isLoading;
                  },
                  builder: (context, state) {
                    final isLoading =
                        state is AuthLoading &&
                        state.action == AuthAction.resetPassword;
                    return AppElevatedButton(
                      label: AppStrings.changePasswordString,
                      onPressed: isLoading ? null : _handleChangePassword,
                      isLoading: isLoading,
                      backGroundColor: ColorManager.primary,
                      borderRadius: AppSizes.s4,
                      textStyle: AppTextStyles.bold15.withColor(Colors.white),
                    );
                  },
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
