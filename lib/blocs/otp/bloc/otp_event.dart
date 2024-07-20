part of 'otp_bloc.dart';

sealed class OtpAuthEvent extends Equatable {
  const OtpAuthEvent();

  @override
  List<Object> get props => [];
}

class DeviceAuthenticationRequested extends OtpAuthEvent {
  final String otp;

  const DeviceAuthenticationRequested(this.otp);

  @override
  List<Object> get props => [otp];
}


