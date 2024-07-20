// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:rootscards/services/auth_services.dart';

// part 'auth_event.dart';
// part 'auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rootscards/blocs/auth/bloc/auth_event.dart';
import 'package:rootscards/blocs/auth/bloc/auth_state.dart';
import 'package:rootscards/repos/repos.dart';
 
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginSubmitted);
  }

   Future<void> _onLoginSubmitted(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final result = await authRepository.login(event.email, event.password);
      final needsDeviceAuth = result['status'] == '201';
      emit(AuthSuccess(needsDeviceAuth));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
  }

