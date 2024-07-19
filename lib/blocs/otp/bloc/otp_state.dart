part of 'otp_bloc.dart';

sealed class OtpAuthState extends Equatable {
  const OtpAuthState();

  @override
  List<Object> get props => [];
}

final class OtpInitial extends OtpAuthState {}

final class OtpLoadingState extends OtpAuthState {}

final class OtpSuccessState extends OtpAuthState {
  final String authid;
  OtpSuccessState(this.authid);

    @override
  List<Object> get props => [authid];
}

final class OtpFailedState extends OtpAuthState {
  final String message;

  OtpFailedState(this.message);

  @override
  List<Object> get props => [message];
}
