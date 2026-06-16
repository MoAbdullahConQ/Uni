import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_button.dart';
import 'package:uni/features/auth/presentation/manager/otp_cubit/otp_cubit.dart';
import 'package:uni/features/auth/presentation/views/otp_view.dart';
import 'package:uni/features/auth/presentation/views/reset_password_view.dart';
import 'package:uni/features/auth/presentation/views/setup_view.dart';
import 'package:uni/features/auth/presentation/views/widgets/auth_header.dart';

class OtpViewBody extends StatefulWidget {
  const OtpViewBody({super.key, required this.args});

  final OtpArgs args;

  @override
  State<OtpViewBody> createState() => _OtpViewBodyState();
}

class _OtpViewBodyState extends State<OtpViewBody> {
  final _otpController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _otpController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _verify() {
    if (_otpController.text.length == 6) {
      context.read<OtpCubit>().verifyOtp(
        otp: _otpController.text,
        email: widget.args.email,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyles.bold24.copyWith(color: AppColors.primaryColor),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.secondaryColor, width: 2),

      boxShadow: const [
        BoxShadow(
          color: AppColors.lightSecondaryColor,
          blurRadius: 0,
          offset: Offset(0, 0),
          spreadRadius: 4,
        ),
      ],
    );

    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is OtpSuccess) {
          if (widget.args.isRegister) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              SetupView.routeName,
              (route) => false,
            );
          } else {
            Navigator.pushReplacementNamed(
              context,
              ResetPasswordView.routeName,
              arguments: state.token,
            );
          }
        } else if (state is OtpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: AppColors.red,
            ),
          );
        } else if (state is OtpResendFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: AppColors.red,
            ),
          );
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
          vertical: kTopPadding,
        ),
        child: Column(
          children: [
            const SizedBox(height: 56),
            AuthHeader(
              title: 'التأكد من الرمز 🔐',
              subtitle:
                  'تم إرسال رمز التحقق المكون من 6 أرقام إلى\n${widget.args.email}',
            ),

            const SizedBox(height: 32),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Pinput(
                length: 6,
                controller: _otpController,
                focusNode: _focusNode,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                onCompleted: (_) => _verify(),
              ),
            ),

            const SizedBox(height: 16),
            _ResendSection(email: widget.args.email),

            const SizedBox(height: 24),
            BlocBuilder<OtpCubit, OtpState>(
              builder: (context, state) {
                return CustomButton(
                  onPressed: state is OtpLoading ? () {} : _verify,
                  text: state is OtpLoading ? '' : 'تحقق',
                  backgroundColor: AppColors.secondaryColor,
                  prefixIcon: state is OtpLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primaryColor,
                          ),
                        )
                      : null,
                  style: TextStyles.bold16.copyWith(
                    color: AppColors.primaryColor,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ResendSection extends StatelessWidget {
  const _ResendSection({required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpCubit, OtpState>(
      buildWhen: (previous, current) =>
          current is OtpTick ||
          current is OtpResendEnabled ||
          current is OtpResendLoading,
      builder: (context, state) {
        if (state is OtpResendEnabled) {
          return InkWell(
            onTap: () => context.read<OtpCubit>().resendOtp(email: email),
            child: Text(
              'إعادة الإرسال',
              style: TextStyles.semiBold14.copyWith(
                color: AppColors.primaryColor,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.secondaryColor,
              ),
            ),
          );
        }
        if (state is OtpTick) {
          final minutes = (state.secondsRemaining ~/ 60).toString().padLeft(
            2,
            '0',
          );
          final seconds = (state.secondsRemaining % 60).toString().padLeft(
            2,
            '0',
          );
          return Text(
            'تقدر تبعت تاني خلال $minutes:$seconds',
            style: TextStyles.regular14.copyWith(
              color: AppColors.subtitleColor,
            ),
          );
        }
        if (state is OtpResendLoading) {
          return const SizedBox(
            height: 20,
            width: 20,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
