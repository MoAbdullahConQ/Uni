import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/features/auth/domain/use_cases/resend_otp_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/verify_otp_use_case.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final VerifyOtpUseCase verifyOtpUseCase;
  final ResendOtpUseCase resendOtpUseCase;

  OtpCubit({required this.verifyOtpUseCase, required this.resendOtpUseCase})
    : super(OtpInitial());

  Timer? _timer;
  static const int _timerDuration = 30;

  // start the countdown timer on screen open
  void startTimer() {
    _timer?.cancel();
    int seconds = _timerDuration;
    emit(OtpTick(seconds));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      seconds--;
      if (seconds <= 0) {
        timer.cancel();
        emit(OtpResendEnabled());
      } else {
        emit(OtpTick(seconds));
      }
    });
  }

  Future<void> verifyOtp({required String otp, required String email}) async {
    emit(OtpLoading());
    final result = await verifyOtpUseCase.call(otp: otp, email: email);
    result.fold((failure) => emit(OtpFailure(failure.message)), (token) {
      _timer?.cancel(); // stop only on success
      emit(OtpSuccess(token));
    });
  }

  Future<void> resendOtp({required String email}) async {
    emit(OtpResendLoading());
    final result = await resendOtpUseCase.call(email: email);
    result.fold((failure) => emit(OtpResendFailure(failure.message)), (_) {
      emit(OtpResendSuccess());
      // restart the timer after resend
      startTimer();
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
