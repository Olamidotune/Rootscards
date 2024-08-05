part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordEmailEvent extends ForgotPasswordEvent {
  final String email;

  ForgotPasswordEmailEvent({required this.email});

  @override
  List<Object> get props => [email];
}
