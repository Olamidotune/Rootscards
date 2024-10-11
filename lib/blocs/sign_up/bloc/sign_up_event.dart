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

class SignUp extends SignUpEvent {
  final String email;
  final String password;
  final String fullName;
  final String phoneNumber;
  final String account;
  final String referer;

  const SignUp({
    required this.email,
    required this.password,
    required this.fullName,
    required this.phoneNumber,
    required this.account,
    required this.referer,
  });

  @override
  List<Object> get props => [
        email,
        password,
        fullName,
        phoneNumber,
        account,
        referer,
      ];
}
