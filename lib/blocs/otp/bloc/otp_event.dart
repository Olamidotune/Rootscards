part of 'otp_bloc.dart';

sealed class OtpAuthEvent extends Equatable {
  const OtpAuthEvent();

  @override
  List<Object> get props => [];
}

class AuthorizeDeviceEvent extends OtpAuthEvent {
  final String otp;

  AuthorizeDeviceEvent(this.otp);

  @override
  List<Object> get props => [otp];
}
