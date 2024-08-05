part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

final class ForgotPasswordInitial extends ForgotPasswordState {}

final class ForgotPasswordLoadingState extends ForgotPasswordState {}

final class ForgotPasswordSuccessState extends ForgotPasswordState {
  final String message;

  ForgotPasswordSuccessState({required this.message});
}

final class ForgotPasswordFailedState extends ForgotPasswordState {
  final String message;

  ForgotPasswordFailedState({required this.message});
}

final class ForgotPasswordErrorState extends ForgotPasswordState {
  final String errorMessage;

  ForgotPasswordErrorState({required this.errorMessage});
}
