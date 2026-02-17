import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taskor/core/config/constants/app_sizes.dart';
import 'package:taskor/core/config/constants/app_strings.dart';
import 'package:taskor/core/config/constants/app_text_styles.dart';
import 'package:taskor/core/config/constants/color_manager.dart';
import 'package:taskor/core/config/extensions/text_style_extension.dart';
import 'package:taskor/core/config/extensions/validation_extension.dart';
import 'package:taskor/core/config/router/routers_name.dart';
import 'package:taskor/core/config/widgets/app_elevated_button.dart';
import 'package:taskor/core/config/widgets/app_header.dart';
import 'package:taskor/core/config/widgets/otp_field.dart';
import 'package:taskor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskor/features/auth/presentation/bloc/auth_event.dart';
import 'package:taskor/features/auth/presentation/bloc/auth_state.dart';

class EnterCodePage extends StatefulWidget {
  const EnterCodePage({
    super.key,
    required this.email,
    required this.verificationCode,
  });

  final String email;
  final String verificationCode;

  @override
  State<EnterCodePage> createState() => _EnterCodePageState();
}

class _EnterCodePageState extends State<EnterCodePage> {
  String _code = '';
  bool? _isCodeValid;
  String? _errorMessage;

  void _handleCodeChanged(String value) {
    setState(() {
      _code = value;
      _isCodeValid = null;
      _errorMessage = null;
    });
  }

  void _handleVerify() {
    final error = _code.validateCode(length: 4);
    if (error != null) {
      setState(() {
        _isCodeValid = false;
        _errorMessage = error;
      });
      return;
    }

    FocusScope.of(context).unfocus();
    context.read<AuthBloc>().add(
      VerifyResetCodeEvent(email: widget.email, code: _code.trim()),
    );
  }

  Color _currentBorderColor() {
    if (_isCodeValid == null) {
      return ColorManager.subtitleAndToDoColor;
    }

    return _isCodeValid! ? ColorManager.doneColor : ColorManager.errorColor;
  }

  @override
  Widget build(BuildContext context) {
    final errorTextStyle = AppTextStyles.medium11.withColor(
      ColorManager.errorColor,
    );
    final validTextStyle = AppTextStyles.medium11.withColor(
      ColorManager.doneColor,
    );

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthForgotPasswordSuccess && state.email == widget.email) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Verification code resent')),
          );
          return;
        }

        if (state is AuthVerifyResetCodeSuccess) {
          setState(() {
            _isCodeValid = true;
            _errorMessage = null;
          });

          context.go(
            RoutesName.resetPassword,
            extra: <String, String>{'email': state.email, 'code': state.code},
          );

          return;
        }

        if (state is AuthError && state.action == AuthAction.verifyResetCode) {
          setState(() {
            _isCodeValid = false;
            _errorMessage = state.message;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.s20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppSizes.s12),
                const AppHeader(title: AppStrings.enterCodeTitleString),
                const SizedBox(height: AppSizes.s16),
                Text(
                  AppStrings.enterCodeSubtitleString,
                  style: AppTextStyles.regular13,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSizes.s8),
                Text(
                  'Training code: ${widget.verificationCode}',
                  style: AppTextStyles.regular10.withColor(
                    ColorManager.primary,
                  ),
                ),
                const SizedBox(height: AppSizes.s24),
                OtpFieldWidget(
                  borderColor: _currentBorderColor(),
                  focusedBorderColor: _currentBorderColor(),
                  onChanged: _handleCodeChanged,
                  onCompleted: _handleCodeChanged,
                ),
                if (_isCodeValid != null) ...[
                  const SizedBox(height: AppSizes.s12),
                  Text(
                    _isCodeValid!
                        ? AppStrings.correctCodeString
                        : (_errorMessage ?? AppStrings.verifyCodeErrorString),
                    style: _isCodeValid! ? validTextStyle : errorTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: AppSizes.s48),
                Text(
                  AppStrings.dontReceiveCodeString,
                  style: AppTextStyles.regular10,
                ),
                const SizedBox(height: AppSizes.s10),
                GestureDetector(
                  onTap: () => context.read<AuthBloc>().add(
                    ForgotPasswordEvent(widget.email),
                  ),
                  child: Text(
                    AppStrings.resendCodeString,
                    style: AppTextStyles.regular10.withColor(
                      ColorManager.primary,
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.s24),
                AppElevatedButton(
                  label: AppStrings.verifyEmailString,
                  onPressed: _handleVerify,
                  backGroundColor: ColorManager.primary,
                  borderRadius: AppSizes.s4,
                  textStyle: AppTextStyles.bold15.withColor(Colors.white),
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
