part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

final class CheckSignUpMailLoading extends SignUpState {}

final class CheckSignUpMailSuccess extends SignUpState {
  final String message;

  CheckSignUpMailSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}

final class CheckSignUpMailFailed extends SignUpState {
  final String error;

  const CheckSignUpMailFailed(this.error);

  @override
  List<Object> get props => [error];
}

final class CheckSignUpMailError extends SignUpState {
  final String error;

  const CheckSignUpMailError(this.error);

  @override
  List<Object> get props => [error];
}
