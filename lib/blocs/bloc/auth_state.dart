part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccessState extends AuthState {
  final String xpub1;
  final String xpub2;
  final String email;

  AuthSuccessState(
    this.xpub1,
    this.xpub2,
    this.email,
  );

  @override
  List<Object> get props => [
        xpub1,
        xpub2,
        email,
      ];
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}
