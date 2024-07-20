part of 'otp_bloc.dart';

sealed class OtpAuthState extends Equatable {
  const OtpAuthState();

  @override
  List<Object> get props => [];
}

final class OtpInitial extends OtpAuthState {}

final class OtpLoadingState extends OtpAuthState {}

class DeviceAuthenticationSuccess extends OtpAuthState {
  final String authId;

  const DeviceAuthenticationSuccess(this.authId);

  @override
  List<Object> get props => [authId];
}

final class OtpFailedState extends OtpAuthState {
  final String message;

  OtpFailedState(this.message);

  @override
  List<Object> get props => [message];
}
