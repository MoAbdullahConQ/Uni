part of 'otp_cubit.dart';

abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {
  final String token;

  OtpSuccess(this.token);
}

class OtpFailure extends OtpState {
  final String errMessage;

  OtpFailure(this.errMessage);
}

class OtpResendLoading extends OtpState {}

class OtpResendSuccess extends OtpState {}

class OtpResendFailure extends OtpState {
  final String errMessage;

  OtpResendFailure(this.errMessage);
}

class OtpTick extends OtpState {
  final int secondsRemaining;
  
  OtpTick(this.secondsRemaining);
}

class OtpResendEnabled extends OtpState {}
