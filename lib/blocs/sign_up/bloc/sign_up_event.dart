part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class CheckSignUpMail extends SignUpEvent {
  final String email;
  final String password;

  const CheckSignUpMail(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}


