import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:taskor/core/config/constants/app_sizes.dart';
import 'package:taskor/core/config/constants/app_strings.dart';
import 'package:taskor/core/config/constants/app_text_styles.dart';
import 'package:taskor/core/config/constants/color_manager.dart';
import 'package:taskor/core/config/constants/icon_path.dart';
import 'package:taskor/core/config/extensions/padding_extension.dart';
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

class EnterEmailAddressPage extends StatefulWidget {
  const EnterEmailAddressPage({super.key});

  @override
  State<EnterEmailAddressPage> createState() => _EnterEmailAddressPageState();
}

class _EnterEmailAddressPageState extends State<EnterEmailAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    FocusScope.of(context).unfocus();
    context.read<AuthBloc>().add(
      ForgotPasswordEvent(_emailController.text.trim()),
    );
  }

  void _handleCancel() {
    FocusScope.of(context).unfocus();
    context.go(RoutesName.login);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthForgotPasswordSuccess) {
          context.go(
            RoutesName.verifyCode,
            extra: <String, String>{
              'email': state.email,
              'verificationCode': state.verificationCode,
            },
          );
          return;
        }

        if (state is AuthError && state.action == AuthAction.forgotPassword) {
          AppSnackBar.showError(context, message: state.message);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSizes.s12),
                AppHeader(
                  title: AppStrings.enterEmailAddressTitleString,
                  onBack: _handleCancel,
                ),
                const SizedBox(height: AppSizes.s16),
                Text(
                  AppStrings.enterYourEmailSubtitleString,
                  style: AppTextStyles.regular13,
                ),
                const SizedBox(height: AppSizes.s24),
                Form(
                  key: _formKey,
                  child: AppTextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    enableSuggestions: false,
                    smartDashesType: SmartDashesType.disabled,
                    smartQuotesType: SmartQuotesType.disabled,
                    hintText: Text(
                      AppStrings.enterYourEmailHintString,
                      style: AppTextStyles.regular11,
                    ),
                    errorStyle: AppTextStyles.medium11.withColor(
                      ColorManager.errorColor,
                    ),
                    errorMaxLines: 3,
                    errorSpacing: AppSizes.s12,
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
                    validator: (value) {
                      final trimmed = value?.trim() ?? '';
                      if (trimmed.isEmpty) {
                        return 'Email is required.';
                      }

                      return value.validateEmail(fieldName: 'email');
                    },
                  ),
                ),
                const SizedBox(height: AppSizes.s32),
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) {
                    final wasLoading =
                        previous is AuthLoading &&
                        previous.action == AuthAction.forgotPassword;
                    final isLoading =
                        current is AuthLoading &&
                        current.action == AuthAction.forgotPassword;
                    return wasLoading != isLoading;
                  },
                  builder: (context, state) {
                    final isLoading =
                        state is AuthLoading &&
                        state.action == AuthAction.forgotPassword;
                    return AppElevatedButton(
                      label: AppStrings.continueString,
                      onPressed: isLoading ? null : _handleContinue,
                      isLoading: isLoading,
                      backGroundColor: ColorManager.primary,
                      borderRadius: AppSizes.s4,
                      textStyle: AppTextStyles.bold15.withColor(Colors.white),
                    );
                  },
                ),
                const SizedBox(height: AppSizes.s12),
                AppElevatedButton(
                  label: AppStrings.cancelString,
                  onPressed: _handleCancel,
                  backGroundColor: Colors.white,
                  borderRadius: AppSizes.s4,
                  borderColor: ColorManager.primary,
                  textStyle: AppTextStyles.semiBold15,
                ),
                const SizedBox(height: AppSizes.s24),
              ],
            ).padSym(horizontal: AppSizes.icon20),
          ),
        ),
      ),
    );
  }
}
