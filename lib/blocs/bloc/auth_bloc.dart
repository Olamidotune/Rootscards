import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rootscards/services/auth_services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthServices authServices;

  AuthBloc(this.authServices) : super(AuthInitial()) {
    on<LoginEvent>(_authenticated);
  }

  FutureOr<void> _authenticated(
      LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final success = await authServices.login(event.email, event.password);
      if (success) {
        emit(
          AuthSuccessState(
            'xpub1',
            'xpub2',
            'email',
          ),
        ); 
      } else {
        emit(AuthFailure('Login failed'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
