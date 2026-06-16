import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/services/get_it_service.dart';
import 'package:uni/core/widgets/back_button.dart';
import 'package:uni/features/auth/domain/use_cases/resend_otp_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/verify_otp_use_case.dart';
import 'package:uni/features/auth/presentation/manager/otp_cubit/otp_cubit.dart';
import 'package:uni/features/auth/presentation/views/widgets/otp_view_body.dart';

// args passed from SignUpView or ForgotPasswordView so OtpView knows
// where to navigate next and which email to verify
class OtpArgs {
  final String email;
  final bool isRegister;

  OtpArgs({required this.email, required this.isRegister});
}

class OtpView extends StatelessWidget {
  const OtpView({super.key, required this.args});

  static const String routeName = 'otp';

  final OtpArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(
        verifyOtpUseCase: getIt<VerifyOtpUseCase>(),
        resendOtpUseCase: getIt<ResendOtpUseCase>(),
      )..startTimer(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              OtpViewBody(args: args),
              const Positioned(
                top: 16,
                right: 16,
                child: CustomBackButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
