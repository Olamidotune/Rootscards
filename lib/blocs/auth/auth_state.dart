import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final bool needsDeviceAuth;

  AuthSuccess({required this.needsDeviceAuth});

  @override
  List<Object> get props => [needsDeviceAuth];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}

class AuthError extends AuthState {
  final String error;

  AuthError({required this.error});

  @override
  List<Object> get props => [error];
}
