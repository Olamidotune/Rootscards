import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rootscards/repos/repos.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepository;

  SignUpBloc(this.authRepository) : super(SignUpInitial()) {
    on<CheckSignUpMail>(_checkSignUpMail);
    on<SignUp>(_signUp);
  }

  Future<void> _checkSignUpMail(
      CheckSignUpMail event, Emitter<SignUpState> emit) async {
    emit(CheckSignUpMailLoading());
    try {
      final bool emailExists = await authRepository.checkSignUpEmail(
        event.email,
        event.password,
      );
      if (emailExists) {
        emit(
          CheckSignUpMailSuccess(
            message:
                "Opps! Email already exists, login with your existing email and password",
          ),
        );
      } else {
        emit(CheckSignUpMailFailed("Compelete your sign up process"));
      }
    } catch (e) {
      print(e);
      if (e.toString().contains('Network error') ||
          e.toString().contains('Connection timed out')) {
        emit(CheckSignUpMailError(
            "Network error. Please check your internet connection."));
      } else {
        emit(CheckSignUpMailError("Something went wrong. Please try again."));
      }
    }
  }

  Future<void> _signUp(SignUp event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());
    try {
      final bool success = await authRepository.signUp(
          event.email,
          event.password,
          event.fullName,
          event.phoneNumber,
          event.account,
          event.referer);
      if (success) {
        emit(SignUpSuccess(message: "Sign up successful"));
      } else {
        emit(
          SignUpFailed(
            "Email already exists, login with your existing email and password",
          ),
        );
      }
    } catch (e) {
      print(e);
      if (e.toString().contains('Network Error') ||
          e.toString().contains('Connection timed out')) {
        emit(SignUpError(
            'Network error. Please check your internet connection.'));
      } else {
        emit(SignUpError('Something went wrong. Please try again'));
      }
    }
  }
}
